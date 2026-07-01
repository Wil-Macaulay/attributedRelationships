//
//  attributedRelationshipsTests.swift
//  attributedRelationshipsTests
//
//  Created by wil macaulay on 2025-12-28.
//

import Testing
import CoreData
@testable import attributedRelationships

@Suite("Database tests (serialized)",.serialized)
struct attributedRelationshipsTests {
    let appDelegate = AppDelegate.sharedDelegate
    var context = AppDelegate.sharedDelegate.persistentContainer.newBackgroundContext() // serialized so we can use one

    @Test("Starting")
    func starting() {
        #expect ("yes" == "yes")
    }
    
    //this is disabled because I'm using the "/dev/null" technique in appDelegate
    @Test("reset") // ,.disabled())
    func resetDatabase() throws {
        try appDelegate.resetDatabase()
        let context = appDelegate.persistentContainer.newBackgroundContext()
        let collectionsFetchRequest = TDMCollection.fetchRequest()
        do {
            let _ = try context.fetch(collectionsFetchRequest)
            let count = try context.count(for:collectionsFetchRequest)
            #expect( count == 0 )
        }
        catch {
            print("can't fetch")
        }
        
    }
    
    //I had to use newBackgroundContext() instead of viewcontext because SwiftTesting runs in parallel for the arguments
    @Test("Making Tunes",arguments: ["A tune","B tune","C tune","D tune","ambiguousSearchable"])
    func makeTune(_ tuneName: String) {
        //let context = appDelegate.persistentContainer.newBackgroundContext()
        _ = TDMTune.makeInstance(context: context, displayName: tuneName)
        do {
            try context.save()
            let (result,count) = try TDMTune.fetchByName(name: tuneName, context: context)
            #expect( count == 1 )
            let tune = result[0]
            #expect(tune.displayName == tuneName )
        }
        catch {
            print("can't fetch tunes")
        }

    }
    
    
    
    static let tuneDict : [String  : Any] = [
        "displayName" : "tune from Dict",
        "notes" : "this was created from a dictionary"
    ]
    
    static let tune2Dict : [String : Any] = [
        "displayName" : "tune with old dates",
        "notes" : "should have ancient created and modified dates",
        "createdDateTime" : Date(timeIntervalSinceNow: -(200 * 60 * 60 * 24)),
        "modifiedDateTime" : Date(timeIntervalSinceNow: -(60 * 60 * 24)),

    ]
    
    
    @Test("Making Empty TuneSets", arguments: ["1 Set","2 Set","3 Set", "4 Set","ambiguousSearchable"])
    func makeTuneSet(_ tuneSetName : String) {
        //let context = appDelegate.persistentContainer.newBackgroundContext()
        _ = TDMTuneSet.makeInstance(context: context, displayName: tuneSetName)
        do {
            try context.save()
            let (result,count) = try TDMTuneSet.fetchByName(name: tuneSetName, context: context)
            #expect( count == 1 )
            let tuneSet = result[0]
            #expect(tuneSet.displayName == tuneSetName )
        }
        catch {
            print("can't fetch tune sets")
        }

    }
    
    @Test("Making Empty Collections",arguments: ["A Collection","B Collection","C Collection", "D Collection"])
    func makeCollection(_ collectionName : String) {
        //let context = appDelegate.persistentContainer.newBackgroundContext()
        _ = TDMCollection.makeInstance(context: context, displayName: collectionName)
        do {
            try context.save()
            let (result,count) = try TDMCollection.fetchByName(name: collectionName, context: context)
            #expect( count == 1 )
            let collection = result[0]
            #expect(collection.displayName == collectionName )
        }
        catch {
            print("can't fetch collections")
        }
    }
    
    static let orderedTunes  = ["A tune","C tune","D tune","B tune"]
    
    // Need to make sure I can add tunes in an arbitrary order to a set
    @Test("Add tunes to a set (ordered)",arguments:orderedTunes, ["1 Set","2 Set"])
    func addTune(_ tuneName: String, toSet setName : String ){
        do {
            let (tuneSets,count) = try TDMTuneSet.fetchByName(name: setName, context: context)
            try #require( count == 1)
            let (tunes,tune1count) = try TDMTune.fetchByName(name: tuneName, context: context)
            try #require( tune1count == 1)
            let tuneSet = tuneSets[0] as TDMTuneSet
            let tune = tunes[0] as TDMTune
                tuneSet.addToTunes(tune)
            if let lastTune : TDMTune = tuneSet.tunes?.lastObject as? TDMTune {
                print("Last tune: \(lastTune.displayName ?? "unassigned")")
                #expect(lastTune == tune)
            } else {
                #expect(Bool(false))
            }
            // now test they are ordered correctly
            if let count = tuneSet.tunes?.count {
                print("in set \(tuneSet.displayName ?? "<unknown>") with \(count) items")
                for index in 0 ..< count{
                    let tune = tuneSet.tunes?[index] as? TDMTune
                    print("  \(tune?.displayName ?? "<unassigned display name>")")
                    #expect(tune?.displayName == attributedRelationshipsTests.orderedTunes[index])
                        
                }
            }
            try context.save()
        }
        catch {
            print("can't get tuneset")
        }
    }

  // remove a tune from a set
    // should not change the order of the remaining items
    // should decrement the number of items in the set
    // item should still exist
  @Test("Remove tune from a set (preserve order)",arguments:["D tune"],["1 Set"])
    func removeTune(_ tuneName: String, fromSet setName: String ) {
        do {
            let (tuneSets,count) = try TDMTuneSet.fetchByName(name: setName, context: context)
            try #require( count == 1)
            let (tunes,tune1count) = try TDMTune.fetchByName(name: tuneName, context: context)
            try #require( tune1count == 1)
            
            // capture the tunes that were in the set
            let tuneSet = tuneSets[0] as TDMTuneSet
            let tune = tunes[0] as TDMTune
            let tunesArray : [TDMTune] = tuneSet.tunes?.array as! [TDMTune]
            #expect (tunesArray.contains(tune))
            var tuneNames : [String] =  tunesArray.map{$0.displayName!} // assumes displayName is assigned
            print(tuneNames)
            tuneSet.removeFromTunes(tune)
            tuneNames.removeAll(where: {tuneName == $0 })
            print(tuneNames)
            #expect ((tuneSet.tunes?.contains(tune)) == false)
            for index in 0..<tuneNames.count {
                let tune : TDMTune = tuneSet.tunes?[index] as! TDMTune
                #expect(tuneNames[index] == tune.displayName )
            }
            try context.save()
        }
        catch {
            print("core data error")
        }
        do {
            let (_,count) = try TDMTune.fetchByName(name: tuneName, context: context)
            try #require( count == 1 )
        } catch {
            print("core data error")
        }
    }
    
    
    func set(_ setName: String, containsTune tuneName : String ) -> Bool {
        do {
            let (tuneSets,count) = try TDMTuneSet.fetchByName(name: setName, context: context)
            try #require( count == 1)
            let (tunes,tune1count) = try TDMTune.fetchByName(name: tuneName, context: context)
            try #require( tune1count == 1)
            // capture the tunes that were in the set
            let tuneSet = tuneSets[0] as TDMTuneSet
            let tune = tunes[0] as TDMTune
            let tunesArray : [TDMTune] = tuneSet.tunes?.array as! [TDMTune]
            if tunesArray.contains(tune) {
                return true
            } else {
                return false
            }
        }
        catch {
            print("core data error")
            return false
        }

        
    }
    
    // delete a Tune that is in a Set
    // should not change the order of the remaining items
    // should decrement the number of items in the set
    // item should no longer exist
    // item should be removed from all sets
    @Test("Delete tune that is in Set",arguments: ["C tune"],["2 Set"])
    func deleteTuneInSet(_ tuneName: String, fromSet setName: String ) {
        do {
            let (tuneSets,count) = try TDMTuneSet.fetchByName(name: setName, context: context)
            try #require( count == 1)
            let (tunes,tune1count) = try TDMTune.fetchByName(name: tuneName, context: context)
            try #require( tune1count == 1)
            
            // capture the tunes that were in the set
            let tuneSet = tuneSets[0] as TDMTuneSet
            let tune = tunes[0] as TDMTune
            let tunesArray : [TDMTune] = tuneSet.tunes?.array as! [TDMTune]
            #expect (tunesArray.contains(tune))
            var tuneNames : [String] =  tunesArray.map{$0.displayName!} // assumes displayName is assigned
            print(tuneNames)
            //tuneSet.removeFromTunes(tune)
            try TDMTune.deleteByName(name:tuneName, context:context)
            print(tuneNames)
            try context.save() //the save triggers the autodeletion cascade of the reference
            #expect ((tuneSet.tunes?.contains(tune)) == false) // assumes autodelete
            tuneNames.removeAll(where: {tuneName == $0 })
            for index in 0..<tuneNames.count {
                let tune : TDMTune = tuneSet.tunes?[index] as! TDMTune
                #expect(tuneNames[index] == tune.displayName )
            }
        }
        catch {
            print("core data error")
        }
        do {
            let (_,count) = try TDMTune.fetchByName(name: tuneName, context: context)
            try #require( count == 0 )
            
        } catch {
            print("core data error")
        }

    }

    
    
    // Need to make sure I can add tunes in an arbitrary order to a collection
    // note that 'items' is an NSOrderedSet? - when I change over to the new backing model I need to present an 'items' facade
    
    static let orderedItems = ["A tune","1 Set","B tune","D tune","3 Set"]

    @Test("Add items to a collection (ordered)",arguments:orderedItems ,["A Collection"])
    func addItem(_ itemName: String, toCollection collectionName : String){
        do {
            let (collections,count) = try TDMCollection.fetchByName(name: collectionName, context: context)
            try #require( count == 1)
            let (items,item1count) = try TDMSearchable.fetchItemByName(name: itemName, context: context)
            try #require( item1count == 1)
            let collection = collections[0] as TDMCollection
            let item = items[0] as TDMSearchable
            collection.addToItems(item)
            if let lastItem : TDMSearchable = collection.items?.lastObject as? TDMSearchable {
                print("Last item: \(lastItem.displayName ?? "unassigned")")
                #expect(lastItem == item)
            } else {
                #expect(Bool(false))
            }
            // now test they are ordered correctly
            if let count = collection.items?.count {
                print("in collection \(collection.displayName ?? "<unknown>") with \(count) items")
                for index in 0 ..< count{
                    let item = collection.items?[index] as? TDMSearchable
                    print("  \(item?.displayName ?? "<unassigned display name>")")
                    #expect(item?.displayName == attributedRelationshipsTests.orderedItems[index])
                }
            }
            try context.save()
        }
        catch {
            print("can't get collection")
        }
    }
    
    // add an item that is already in a set - should have no effect
    // reorder items (change an item's index)

     
    @Test("Remove tune from collection (preserve order)", arguments: ["B tune"], ["A Collection"])
    func removeItem(_ itemName : String, fromCollection collectionName : String) {
        do {
            let (collections,count) = try TDMCollection.fetchByName(name: collectionName, context: context)
            try #require( count == 1)
            let (items,itemCount) = try TDMSearchable.fetchItemByName(name: itemName, context: context)
            try #require( itemCount == 1)
            
            // capture the items that were in the set
            let collection = collections[0] as TDMCollection
            let item = items[0] as TDMSearchable
            let itemsArray : [TDMSearchable] = collection.items?.array as! [TDMSearchable]
            #expect (itemsArray.contains(item))
            var itemNames : [String] =  itemsArray.map{$0.displayName!} // assumes displayName is assigned
            print(itemNames)
            collection.removeFromItems(item)
            itemNames.removeAll(where: {itemName == $0 })
            print(itemNames)
            #expect (((collection.items?.contains(item)) == false))
            for index in 0..<itemNames.count {
                let tune : TDMSearchable = collection.items?[index] as! TDMSearchable
                #expect(itemNames[index] == tune.displayName )
            }
            try context.save()
        }
        catch {
            print("core data error")
        }

    }
    @Test("Delete tune that is in Collection")
    func deleteTuneInCollection() {
         #expect(false)
        
    }
    
    


}
