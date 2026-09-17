//
//  TDMTune_TuneSet+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-09-17.
//
//

public import Foundation
public import CoreData


public typealias TDMTune_TuneSetCoreDataPropertiesSet = NSSet

extension TDMTune_TuneSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMTune_TuneSet> {
        return NSFetchRequest<TDMTune_TuneSet>(entityName: "TDMTune_TuneSet")
    }

    @NSManaged public var playOrder: Int64
    @NSManaged public var tune: TDMTune?
    @NSManaged public var set: TDMTuneSet?

}

extension TDMTune_TuneSet : Identifiable {

}
