//
//  TDMTuneSet+CoreDataClass.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//
//

public import Foundation
import CoreData

public typealias TDMTuneSetCoreDataClassSet = NSSet

@objc(TDMTuneSet)
public class TDMTuneSet: TDMSearchable {
    
    override class func makeInstance(from abcObj: some AbcCollectable, context: NSManagedObjectContext) -> TDMTuneSet? {
        guard abcObj.itemType == "tuneSet" else {
            print("not a tuneSet")
            return nil
        }
        var newInstance = super.makeInstance(context: context, displayName: abcObj.displayName, notes: abcObj.notes) as! TDMTuneSet
        
        //use the modified and created dateTime from the DTO
        newInstance.modifiedDateTime = abcObj.modifiedDateTime
        newInstance.createdDateTime = abcObj.createdDateTime
        newInstance.uniqueId = abcObj.uniqueId
        if let items = abcObj.items{
            for item in items {
                if let theTune = TDMTune.makeInstance(from: item, context: context) {
                    newInstance.addTune(theTune)
                }
            }
        }
        
        return newInstance
    }


}
