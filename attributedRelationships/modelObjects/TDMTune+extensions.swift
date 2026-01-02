//
//  TDMTune+extensions.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-01-02.
//

import Foundation
import CoreData
// I need to restrict the fetch request to specific entities

extension TDMTune {
    // we might have multiple items with the same name when we are reconciling.
    class func fetchByName(name: String, context : NSManagedObjectContext)throws ->([TDMTune],Int) {
        let fetchRequest : NSFetchRequest<TDMTune> = fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "displayName == %@", name )
        do {
            let result = try context.fetch(fetchRequest)
            return try (result,context.count(for: fetchRequest))
        }
    }
}
