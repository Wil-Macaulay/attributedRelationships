//
//  TDMCollection+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//
//

public import Foundation
public import CoreData


public typealias TDMCollectionCoreDataPropertiesSet = NSSet

extension TDMCollection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMCollection> {
        return NSFetchRequest<TDMCollection>(entityName: "TDMCollection")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var createdDateTime: Date?
    @NSManaged public var modifiedDateTime: Date?
    @NSManaged public var items: NSOrderedSet?

}

// MARK: Generated accessors for items
extension TDMCollection {

    @objc(insertObject:inItemsAtIndex:)
    @NSManaged public func insertIntoItems(_ value: TDMSearchable, at idx: Int)

    @objc(removeObjectFromItemsAtIndex:)
    @NSManaged public func removeFromItems(at idx: Int)

    @objc(insertItems:atIndexes:)
    @NSManaged public func insertIntoItems(_ values: [TDMSearchable], at indexes: NSIndexSet)

    @objc(removeItemsAtIndexes:)
    @NSManaged public func removeFromItems(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAtIndex:withObject:)
    @NSManaged public func replaceItems(at idx: Int, with value: TDMSearchable)

    @objc(replaceItemsAtIndexes:withItems:)
    @NSManaged public func replaceItems(at indexes: NSIndexSet, with values: [TDMSearchable])

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: TDMSearchable)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: TDMSearchable)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSOrderedSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSOrderedSet)

}

extension TDMCollection : Identifiable {

}
