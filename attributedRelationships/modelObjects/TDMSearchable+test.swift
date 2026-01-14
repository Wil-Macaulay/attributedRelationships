//
//  TDMSearchable+test.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//

import Foundation
import CoreData

extension TDMSearchable {
    class func makeInstance(context: NSManagedObjectContext, displayName:String, notes:String? = nil) ->  TDMSearchable {
        let now = Date()
        let newInstance = Self.init(context: context)
        newInstance.displayName = displayName
        newInstance.notes = notes
        newInstance.createdDateTime = now
        newInstance.modifiedDateTime = now
        newInstance.collatingName = collatingName(displayName: displayName)
        return newInstance
                
    }
    
    // naming this to avoid name conflict with subclasses
    class func fetchItemByName(name: String, context : NSManagedObjectContext)throws ->([TDMSearchable],Int) {
        let fetchRequest : NSFetchRequest<TDMSearchable> = fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "displayName == %@", name )
        do {
            let result = try context.fetch(fetchRequest)
            return try (result,context.count(for: fetchRequest))
        }
    }

    
    class func collatingName(displayName:String?) -> String?{
        return displayName
    }
    

}

