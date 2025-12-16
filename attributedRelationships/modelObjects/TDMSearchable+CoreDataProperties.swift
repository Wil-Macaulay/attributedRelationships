//
//  TDMSearchable+CoreDataProperties.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//
//

public import Foundation
public import CoreData


public typealias TDMSearchableCoreDataPropertiesSet = NSSet

extension TDMSearchable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDMSearchable> {
        return NSFetchRequest<TDMSearchable>(entityName: "TDMSearchable")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var collatingName: String?
    @NSManaged public var createdDateTime: Date?
    @NSManaged public var modifiedDateTime: Date?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var notes: String?
    @NSManaged public var collections: TDMCollection?

}

extension TDMSearchable : Identifiable {

}
