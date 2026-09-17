//
//  TDMCollection+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-09-17.
//
//

public import Foundation
public import CoreData


public typealias TDMCollectionCoreDataPropertiesSet = NSSet

extension TDMCollection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMCollection> {
        return NSFetchRequest<TDMCollection>(entityName: "TDMCollection")
    }

    @NSManaged public var createdDateTime: Date?
    @NSManaged public var displayName: String?
    @NSManaged public var modifiedDateTime: Date?
    @NSManaged public var uniqueId: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension TDMCollection {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: TDMSearchable_Collection)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: TDMSearchable_Collection)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension TDMCollection : Identifiable {

}
