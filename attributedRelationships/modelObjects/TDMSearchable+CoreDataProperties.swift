//
//  TDMSearchable+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-09-17.
//
//

public import Foundation
public import CoreData


public typealias TDMSearchableCoreDataPropertiesSet = NSSet

extension TDMSearchable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMSearchable> {
        return NSFetchRequest<TDMSearchable>(entityName: "TDMSearchable")
    }

    @NSManaged public var collatingName: String?
    @NSManaged public var createdDateTime: Date?
    @NSManaged public var displayName: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var modifiedDateTime: Date?
    @NSManaged public var notes: String?
    @NSManaged public var uniqueId: String?
    @NSManaged public var collections: TDMSearchable_Collection?

}

extension TDMSearchable : Identifiable {

}
