//
//  AbcTuneSet.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-07-01.
//

import Foundation

public class AbcTuneSet : AbcCollectable {

    var tunes : [AbcTune]? = [AbcTune]()
    
    init(displayName: String? = nil, notes: String? = nil, createdDateTime: Date = .now, modifiedDateTime: Date = .now, tunes : [AbcTune]? = [AbcTune]()) {
        super.init(displayName: displayName,notes: notes,createdDateTime: createdDateTime,modifiedDateTime: modifiedDateTime)
        self.tunes = tunes
    }
    
    public enum CodingKeys : String, CodingKey {
        case displayName
        case notes
        case createdDateTime
        case modifiedDateTime
        case tunes
    }

    public required init(from decoder: any Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tunes = try container.decodeIfPresent([AbcTune].self, forKey: .tunes)
    }

}
