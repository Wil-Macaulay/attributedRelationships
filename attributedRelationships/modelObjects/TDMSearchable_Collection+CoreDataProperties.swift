//
//  TDMSearchable_Collection+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-09-17.
//
//

public import Foundation
public import CoreData


public typealias TDMSearchable_CollectionCoreDataPropertiesSet = NSSet

extension TDMSearchable_Collection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMSearchable_Collection> {
        return NSFetchRequest<TDMSearchable_Collection>(entityName: "TDMSearchable_Collection")
    }

    @NSManaged public var createdDateTime: Date?
    @NSManaged public var sortOrder: Int32
    @NSManaged public var searchableItem: TDMSearchable?
    @NSManaged public var collection: TDMCollection?

}

extension TDMSearchable_Collection : Identifiable {

}
