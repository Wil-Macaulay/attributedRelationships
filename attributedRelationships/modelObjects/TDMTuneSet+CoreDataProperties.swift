//
//  TDMTuneSet+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-09-17.
//
//

public import Foundation
public import CoreData


public typealias TDMTuneSetCoreDataPropertiesSet = NSSet

extension TDMTuneSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMTuneSet> {
        return NSFetchRequest<TDMTuneSet>(entityName: "TDMTuneSet")
    }

    @NSManaged public var tunes: NSSet?

}

// MARK: Generated accessors for tunes
extension TDMTuneSet {

    @objc(addTunesObject:)
    @NSManaged public func addToTunes(_ value: TDMTune_TuneSet)

    @objc(removeTunesObject:)
    @NSManaged public func removeFromTunes(_ value: TDMTune_TuneSet)

    @objc(addTunes:)
    @NSManaged public func addToTunes(_ values: NSSet)

    @objc(removeTunes:)
    @NSManaged public func removeFromTunes(_ values: NSSet)

}
