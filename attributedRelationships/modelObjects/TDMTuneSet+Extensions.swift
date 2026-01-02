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
}

