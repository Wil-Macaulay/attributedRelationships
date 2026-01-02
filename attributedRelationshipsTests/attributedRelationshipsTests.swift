//
//  attributedRelationshipsTests.swift
//  attributedRelationshipsTests
//
//  Created by wil macaulay on 2025-12-28.
//

import Testing
import CoreData
@testable import attributedRelationships

struct attributedRelationshipsTests {
    let appDelegate = AppDelegate.sharedDelegate

    @Test("Starting")
    func starting() {
        #expect ("yes" == "yes")
    }
    
    //this is disabled because I'm using the "/dev/null" technique in appDelegate
    @Test("reset",.disabled())
    func resetDatabase() throws {
        try appDelegate.resetDatabase()
        let context = appDelegate.persistentContainer.viewContext
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
        let context = appDelegate.persistentContainer.newBackgroundContext()
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
    
    @Test("Making Empty TuneSets", arguments: ["1 Set","2 Set","3 Set", "4 Set","ambiguousSearchable"])
    func makeTuneSet(_ tuneSetName : String) {
        let context = appDelegate.persistentContainer.newBackgroundContext()
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
        let context = appDelegate.persistentContainer.newBackgroundContext()
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
    
    // Need to make sure I can add tunes in an arbitrary order to a set
    @Test("Add tunes to a set (ordered)")
    func addTunesToSet(){
        
    }
    
    // Need to make sure I can add tunes in an arbitrary order to a collection
    // note that 'items' is an NSOrderedSet? - when I change over to the new backing model I need to present an 'items' facade

    @Test("Add tunes to a collection (ordered)")
    func addTunesToCollection(){
        
    }
    
    @Test("Remove tune from a set (preserve order)")
    func removeTuneFromSet() {
        
    }
    
    @Test("Remove tune from collection (preserve order)")
    func removeTuneFromCollection() {
        
    }
    
    @Test("Delete tune that is in Set and Collection")
    func deleteTuneInContainers() {
        
    }
    
    


}
