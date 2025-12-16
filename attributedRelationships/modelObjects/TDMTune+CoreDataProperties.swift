//
//  TDMTune+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//
//

public import Foundation
public import CoreData


public typealias TDMTuneCoreDataPropertiesSet = NSSet

extension TDMTune {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMTune> {
        return NSFetchRequest<TDMTune>(entityName: "TDMTune")
    }

    @NSManaged public var tuneSets: NSSet?

}

// MARK: Generated accessors for tuneSets
extension TDMTune {

    @objc(addTuneSetsObject:)
    @NSManaged public func addToTuneSets(_ value: TDMTuneSet)

    @objc(removeTuneSetsObject:)
    @NSManaged public func removeFromTuneSets(_ value: TDMTuneSet)

    @objc(addTuneSets:)
    @NSManaged public func addToTuneSets(_ values: NSSet)

    @objc(removeTuneSets:)
    @NSManaged public func removeFromTuneSets(_ values: NSSet)

}
