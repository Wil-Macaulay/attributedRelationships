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
    
    class func makeInstance(from abcObj: AbcTuneSet, context: NSManagedObjectContext) -> TDMTuneSet {
        var newInstance = super.makeInstance(context: context, displayName: abcObj.displayName, notes: abcObj.notes) as! TDMTuneSet
        
        if let tunes = abcObj.tunes {
            for tune in tunes {
                let theTune = TDMTune.makeInstance(from: tune, context: context) as! TDMTune
                newInstance.addToTunes(theTune)
            }
        }
        return newInstance
    }


}
