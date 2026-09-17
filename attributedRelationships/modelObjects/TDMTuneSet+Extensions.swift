//
//  TDMTuneSet+Extensions.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-01-02.
//

import Foundation
import CoreData


extension TDMTuneSet {
    // we might have multiple items with the same name when we are reconciling.
    class func fetchByName(name: String, context : NSManagedObjectContext)throws ->([TDMTuneSet],Int) {
        let fetchRequest : NSFetchRequest<TDMTuneSet> = fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "displayName == %@", name )
        do {
            let result = try context.fetch(fetchRequest)
            return try (result,context.count(for: fetchRequest))
        }
    }
    
    func addTune(_ tune : TDMTune){
        let tuneLink = TDMTune_TuneSet(context: managedObjectContext!)
        addToTunes(tuneLink)
        tuneLink.playOrder = Int64(self.tunes!.count)
        tuneLink.tune = tune
    }
    
    func addTunes(_ tunes : [TDMTune]) {
        for tune in tunes {
            addTune(tune)
        }
    }
    
    func getTunes() -> [TDMTune]{
        getTuneLinks().map{$0.tune!}
    }
    
    func getTuneLinks() -> [TDMTune_TuneSet] {
        if let tunes {
            let tunesArray = tunes.allObjects as! [TDMTune_TuneSet]
            let sorted = tunesArray.sorted(by: {$0.playOrder < $1.playOrder})
            return sorted
        } else {
            return [TDMTune_TuneSet]()
        }
        
    }
    
}

