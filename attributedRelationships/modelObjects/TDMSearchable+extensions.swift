//
//  TDMSearchable+extensions.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//

import Foundation
import CoreData

extension TDMSearchable {
    
    
    // naming this to avoid name conflict with subclasses
    class func fetchItemByName(name: String, context : NSManagedObjectContext)throws ->([TDMSearchable],Int) {
        let fetchRequest : NSFetchRequest<TDMSearchable> = fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "displayName == %@", name )
        do {
            let result = try context.fetch(fetchRequest)
            return try (result,context.count(for: fetchRequest))
        }
    }

    
    

}

