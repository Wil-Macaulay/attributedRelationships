//
//  AbcTune.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-07-01.
//

import Foundation

public class AbcTune : AbcCollectable {
    
    public enum CodingKeys : String, CodingKey {
        case displayName
        case notes
        case createdDateTime
        case modifiedDateTime
        case items
        case itemType

    }

    
    public required init(from decoder: any Decoder) throws {
        print("AbcTune init(from decoder:)")
        try super.init(from: decoder)   // inherit base attributesfrom base class
    }
    


    
    
    class func importFromJsonFile(_ fileName : String) -> [AbcTune]{
        var tunes = [AbcTune]()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json")
        if let fileURL {
            do {
                if let content = try String(contentsOf: fileURL, encoding: .utf8).data(using: .utf8){
                    tunes = try decoder.decode([AbcTune].self, from: content)
                }
            } catch {
                print("can't decode file as tunes \(error)")
                return [AbcTune]()
            }
        }
        
        return tunes
    }
}
