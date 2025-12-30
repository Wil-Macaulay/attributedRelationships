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
    @Test(.disabled())
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
    
    @Test("Making Tunes")
    func makeTune() {
        let context = appDelegate.persistentContainer.viewContext
        _ = TDMTune.makeInstance(context: context, displayName: "A tune")
        let tunesFetchRequest : NSFetchRequest<TDMTune> = TDMTune.fetchRequest()
        do {
            try context.save()
            let result = try context.fetch(tunesFetchRequest)
            let count = try context.count(for:tunesFetchRequest)
            #expect( count == 1 )
            let tune = result[0]
            #expect(tune.displayName == "A tune" )
        }
        catch {
            print("can't fetch")
        }

    }
    
    @Test("Making TuneSets")
    func makeTuneSet() {
        let context = appDelegate.persistentContainer.viewContext
        _ = TDMTuneSet.makeInstance(context: context, displayName: "A tuneSet")
        let tuneSetsFetchRequest : NSFetchRequest<TDMTuneSet> = TDMTuneSet.fetchRequest()
        do {
            try context.save()
            let result = try context.fetch(tuneSetsFetchRequest)
            let count = try context.count(for:tuneSetsFetchRequest)
            #expect( count == 1 )
            let tuneSet = result[0]
            #expect(tuneSet.displayName == "A tuneSet" )
        }
        catch {
            print("can't fetch")
        }

    }
    
    @Test("Making Collections")
    func makeCollection() {
        let context = appDelegate.persistentContainer.viewContext
        _ = TDMCollection.makeInstance(context: context, displayName: "A collection")
        let collectionsFetchRequest : NSFetchRequest<TDMCollection> = TDMCollection.fetchRequest()
        do {
            try context.save()
            let result = try context.fetch(collectionsFetchRequest)
            let count = try context.count(for:collectionsFetchRequest)
            #expect( count == 1 )
            let collection = result[0]
            #expect(collection.displayName == "A collection" )
        }
        catch {
            print("can't fetch")
        }
    }


}
