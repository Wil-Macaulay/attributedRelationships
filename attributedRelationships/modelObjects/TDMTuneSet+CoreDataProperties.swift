//
//  TDMTuneSet+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//
//

public import Foundation
public import CoreData


public typealias TDMTuneSetCoreDataPropertiesSet = NSSet

extension TDMTuneSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMTuneSet> {
        return NSFetchRequest<TDMTuneSet>(entityName: "TDMTuneSet")
    }

    @NSManaged public var tunes: NSOrderedSet?

}

// MARK: Generated accessors for tunes
extension TDMTuneSet {

    @objc(insertObject:inTunesAtIndex:)
    @NSManaged public func insertIntoTunes(_ value: TDMTune, at idx: Int)

    @objc(removeObjectFromTunesAtIndex:)
    @NSManaged public func removeFromTunes(at idx: Int)

    @objc(insertTunes:atIndexes:)
    @NSManaged public func insertIntoTunes(_ values: [TDMTune], at indexes: NSIndexSet)

    @objc(removeTunesAtIndexes:)
    @NSManaged public func removeFromTunes(at indexes: NSIndexSet)

    @objc(replaceObjectInTunesAtIndex:withObject:)
    @NSManaged public func replaceTunes(at idx: Int, with value: TDMTune)

    @objc(replaceTunesAtIndexes:withTunes:)
    @NSManaged public func replaceTunes(at indexes: NSIndexSet, with values: [TDMTune])

    @objc(addTunesObject:)
    @NSManaged public func addToTunes(_ value: TDMTune)

    @objc(removeTunesObject:)
    @NSManaged public func removeFromTunes(_ value: TDMTune)

    @objc(addTunes:)
    @NSManaged public func addToTunes(_ values: NSOrderedSet)

    @objc(removeTunes:)
    @NSManaged public func removeFromTunes(_ values: NSOrderedSet)

}
