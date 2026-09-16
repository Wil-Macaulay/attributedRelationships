//
//  TDMTune+CoreDataClass.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//
//

public import Foundation
import CoreData

public typealias TDMTuneCoreDataClassSet = NSSet

@objc(TDMTune)
public class TDMTune: TDMSearchable {
    
    
    override class func makeInstance(from abcObj : some AbcCollectable, context :NSManagedObjectContext) -> TDMTune? {
        guard abcObj.itemType == "tune" else {
            print("not a tune")
            return nil
        }
        var newInstance = super.makeInstance(context: context, displayName: abcObj.displayName, notes: abcObj.notes) as! TDMTune
        //use the modified and created dateTime from the DTO
        newInstance.modifiedDateTime = abcObj.modifiedDateTime
        newInstance.createdDateTime = abcObj.createdDateTime
        newInstance.uniqueId = abcObj.uniqueId
        return newInstance
        
    }

}
