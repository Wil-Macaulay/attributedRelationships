//
//  AbcCollection.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-07-19.
//

import Foundation

public class AbcCollection : AbcCollectable {
    
    enum CollectionCodingKeys : String, CodingKey {
        case displayName
        case notes
        case createdDateTime
        case modifiedDateTime
        case items
        case itemType
    }

    

    class func importFromJsonFile(_ fileName : String) -> [AbcCollection]{
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json")
        var collections = [AbcCollection]()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let fileURL {
            do {
                if let content = try String(contentsOf: fileURL, encoding: .utf8).data(using: .utf8){
                    collections = try decoder.decode([AbcCollection].self, from: content)
                }
            } catch {
                print("can't decode file as collections \(error)")
                return [AbcCollection]()
            }
        }
        
        return collections
    }

}

