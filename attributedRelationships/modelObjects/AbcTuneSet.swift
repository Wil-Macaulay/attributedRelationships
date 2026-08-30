//
//  AbcTuneSet.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-07-01.
//

import Foundation

public class AbcTuneSet : AbcCollectable {

    var tunes : [AbcTune] = [AbcTune]()
    var tuneIds : [String] = [String]()
    
    init(displayName: String? = nil, notes: String? = nil, createdDateTime: Date = .now, modifiedDateTime: Date = .now, tunes : [AbcTune]? = [AbcTune]()) {
        super.init(displayName: displayName,notes: notes,createdDateTime: createdDateTime,modifiedDateTime: modifiedDateTime)
        self.tunes = tunes ?? [AbcTune]()
    }
    
    //NOTE: I have to explicitly redeclare all the CodingKeys here, unlike in AbcTune because I have added an attribute ('tunes')
    //      AbcTune has the same attributes as the base class (for now), so it can inherit CodingKeys
    public enum TuneSetCodingKeys : String, CodingKey {
        case displayName
        case notes
        case createdDateTime
        case modifiedDateTime
        case tunes
        case tuneIds
    }

    public required init(from decoder: any Decoder) throws {
        print("AbcTuneSet init(from decoder:)")
        try super.init(from: decoder)   // inherit base attributesfrom base class
        let container = try decoder.container(keyedBy: TuneSetCodingKeys.self)
        tunes = try container.decodeIfPresent([AbcTune].self, forKey: .tunes) ?? [AbcTune]() // now decode the tunes if present
        tuneIds = try container.decodeIfPresent([String].self, forKey: .tuneIds) ?? [String]() // decode the tuneIds
    }
    
    class func importFromJsonFile(_ fileName : String) -> [AbcTuneSet]{
        var tunesets = [AbcTuneSet]()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json")
        if let fileURL {
            do {
                if let content = try String(contentsOf: fileURL, encoding: .utf8).data(using: .utf8){
                    tunesets = try decoder.decode([AbcTuneSet].self, from: content)
                }
            } catch {
                print("can't decode file as tuneSets \(error)")
                return [AbcTuneSet]()
            }
        }
        
        return tunesets
    }

}
