//
//  AbcCollectable.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-07-01.
//

import Foundation

public class AbcCollectable : Codable {
    let items: [AbcCollectable]?
    let itemType: String
    let notes: String?
    let displayName: String?
    var modifiedDateTime: Date = .now
    var createdDateTime: Date = .now
    
    enum CollectableCodingKeys : String, CodingKey {
        case displayName
        case notes
        case createdDateTime
        case modifiedDateTime
        case items
        case itemType
    }
    
    required public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CollectableCodingKeys.self)
        displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        notes = try container.decodeIfPresent(String.self, forKey: .notes)
        createdDateTime = try container.decodeIfPresent(Date.self, forKey: .createdDateTime) ?? .now
        modifiedDateTime = try container.decodeIfPresent(Date.self, forKey: .modifiedDateTime) ?? .now
        items = try container.decodeIfPresent([AbcCollectable].self, forKey: .items)
        itemType = try container.decode(String.self, forKey: .itemType)
    }
}

