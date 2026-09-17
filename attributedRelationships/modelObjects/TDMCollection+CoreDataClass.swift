//
//  TDMCollection+CoreDataClass.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//
//

public import Foundation
public import CoreData

public typealias TDMCollectionCoreDataClassSet = NSSet

@objc(TDMCollection)
public class TDMCollection: NSManagedObject {
    
    class func makeInstance(context: NSManagedObjectContext, displayName:String?, notes:String? = nil) ->  TDMCollection {
        let now = Date()
        let newInstance = Self.init(context: context)
        newInstance.displayName = displayName
        newInstance.createdDateTime = now
        newInstance.modifiedDateTime = now
        newInstance.uniqueId = UUID().uuidString
        return newInstance
                
    }

    
    class func makeInstance(from abcObj : some AbcCollectable, context :NSManagedObjectContext) -> TDMCollection? {
        guard abcObj.itemType == "collection" else {
            return nil
        }
        let newInstance = self.makeInstance(context: context, displayName: abcObj.displayName, notes: abcObj.notes)
        //use the modified and created dateTime from the DTO
        newInstance.modifiedDateTime = abcObj.modifiedDateTime
        newInstance.createdDateTime = abcObj.createdDateTime
        newInstance.uniqueId = abcObj.uniqueId

        if let items = abcObj.items{
            for item in items {
                if let theTune = TDMTune.makeInstance(from: item, context: context) {
                    newInstance.addSearchableItem(theTune)
                } else if let theTuneSet = TDMTuneSet.makeInstance(from: item, context: context) {
                    newInstance.addSearchableItem(theTuneSet)
                }
            }
        }

        return newInstance
        
    }
    


}
