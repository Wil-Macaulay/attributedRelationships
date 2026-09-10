//
//  AbcTuneSet.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-07-01.
//

import Foundation

public class AbcTuneSet : AbcCollectable {

    var tuneIds : [String] = [String]()
    
    
    //NOTE: I have to explicitly redeclare all the CodingKeys here, unlike in AbcTune because I have added an attribute ('tunes')
    //      AbcTune has the same attributes as the base class (for now), so it can inherit CodingKeys
    public enum TuneSetCodingKeys : String, CodingKey {
        case displayName
        case notes
        case createdDateTime
        case modifiedDateTime
        case tuneIds
        case items
        case itemType
    }

    public required init(from decoder: any Decoder) throws {
        print("AbcTuneSet init(from decoder:)")
        try super.init(from: decoder)   // inherit base attributesfrom base class
        let container = try decoder.container(keyedBy: TuneSetCodingKeys.self)
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
