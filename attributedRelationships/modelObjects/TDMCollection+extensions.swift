//
//  TDMCollection+extensions.swift
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
        newInstance.uniqueId = UUID().uuidString
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
    
    func addSearchableItem(_ item : some TDMSearchable){
        let context = managedObjectContext!
        let linkObject = TDMSearchable_Collection(context: context)
        linkObject.createdDateTime = .now
        linkObject.searchableItem = item
        addToItems(linkObject)
        modifiedDateTime = .now
        linkObject.sortOrder = Int32(items!.count)
   }
    
    func addSearchableItems(_ items : [TDMSearchable]){
        for item in items {
            addSearchableItem(item)
        }
    }
    
    func getSearchableItem(at index : Int)->TDMSearchable?{
        getLinkItem(at: index)?.searchableItem
    }
    
    func getLinkItem(at index : Int) -> TDMSearchable_Collection? {
        guard let items else {
            return nil
        }
        let count = items.count
        let theItemsArray = items.allObjects as! [TDMSearchable_Collection]
        let sortedItems = theItemsArray.sorted(by: {$0.sortOrder < $1.sortOrder})
        if (index < count) && (index >= 0) {
            return sortedItems[index]
        } else {
            return nil
        }
    }
    
    func removeSearchableItem(at index : Int) {
        guard let item = getLinkItem(at: index) else
        {
            return
        }
        if let context = self.managedObjectContext {
            context.delete(item)
            modifiedDateTime = .now
        }
    }
    
    func swapSearchableItem(from : Int, to : Int){
        if let itemFrom = getLinkItem(at: from),
           let itemTo = getLinkItem(at: to){
            let fromOrder = itemFrom.sortOrder
            itemFrom.sortOrder = itemTo.sortOrder
            itemTo.sortOrder = fromOrder
        }
            
        
    }
}
