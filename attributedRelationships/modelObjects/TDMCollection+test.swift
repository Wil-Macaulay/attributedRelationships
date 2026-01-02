//
//  TDMCollection+test.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-15.
//

import Foundation
import CoreData

extension TDMCollection {
    class func makeInstance(context: NSManagedObjectContext, displayName:String, notes:String? = nil) ->  TDMCollection {
        let now = Date()
        let newInstance = Self.init(context: context)
        newInstance.displayName = displayName
        newInstance.createdDateTime = now
        newInstance.modifiedDateTime = now
        return newInstance
    }
    
    // we might have multiple collections with the same name when we are reconciling.
    class func fetchByName(name: String, context : NSManagedObjectContext)throws ->([TDMCollection],Int) {
        let fetchRequest : NSFetchRequest<TDMCollection> = fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "displayName == %@", name )
        do {
            let result = try context.fetch(fetchRequest)
            return try (result,context.count(for: fetchRequest))
        }
    }
}
