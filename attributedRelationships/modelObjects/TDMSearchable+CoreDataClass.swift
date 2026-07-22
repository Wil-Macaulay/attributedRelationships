//
//  TDMSearchable+CoreDataClass.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//
//

public import Foundation
public import CoreData

public typealias TDMSearchableCoreDataClassSet = NSSet

@objc(TDMSearchable)
public class TDMSearchable: NSManagedObject {
    class func makeInstance(context: NSManagedObjectContext, displayName:String?, notes:String? = nil) ->  TDMSearchable {
        let now = Date()
        let newInstance = Self.init(context: context)
        newInstance.displayName = displayName
        newInstance.notes = notes
        newInstance.createdDateTime = now
        newInstance.modifiedDateTime = now
        newInstance.collatingName = collatingName(displayName: displayName)
        return newInstance
                
    }
    
    class func makeInstance(from abcObj : some AbcCollectable, context :NSManagedObjectContext) -> TDMSearchable {
        var newInstance = self.makeInstance(context: context, displayName: abcObj.displayName, notes: abcObj.notes)
        //use the modified and created dateTime from the DTO
        newInstance.modifiedDateTime = abcObj.modifiedDateTime
        newInstance.createdDateTime = abcObj.createdDateTime
        return newInstance
        
    }
    
    class func collatingName(displayName:String?) -> String?{
        return displayName
    }




}
