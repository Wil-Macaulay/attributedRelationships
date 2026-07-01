//
//  AbcTuneSet.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-07-01.
//

import Foundation

public class AbcTuneSet : Codable {
    var displayName : String?
    var notes : String?
    var createdDateTime : Date = .now
    var modifiedDateTime : Date = .now
    var tunes : [AbcTune]? = nil
    
    init(displayName: String? = nil, notes: String? = nil, createdDateTime: Date = .now, modifiedDateTime: Date = .now, tunes : [AbcTune]? = nil) {
        self.displayName = displayName
        self.notes = notes
        self.createdDateTime = createdDateTime
        self.modifiedDateTime = modifiedDateTime
        self.tunes = tunes
    }
    
    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        notes = try container.decodeIfPresent(String.self, forKey: .notes)
        createdDateTime = try container.decodeIfPresent(Date.self, forKey: .createdDateTime) ?? .now
        modifiedDateTime = try container.decodeIfPresent(Date.self, forKey: .modifiedDateTime) ?? .now
        tunes = try container.decodeIfPresent([AbcTune].self, forKey: .tunes)
    }

}
