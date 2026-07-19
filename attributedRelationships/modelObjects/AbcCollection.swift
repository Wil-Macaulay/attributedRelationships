//
//  AbcCollection.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-07-19.
//

import Foundation

public class AbcCollection : Codable {
    var displayName : String?
    var createdDateTime : Date = .now
    var modifiedDateTime : Date = .now
    let items : [CollectionItem]
    
    enum CollectionItem : Codable {
        case tune(AbcTune)
        case tuneSet(AbcTuneSet)
        
        var unassociated : Unassociated {
            switch self {
            case .tune: return .tune
            case .tuneSet: return .tuneSet
            }
        }
        
        enum Unassociated : String {
            case tune
            case tuneSet
        }
        
        private enum CodingKeys : String, CodingKey {
            case itemType
            case attributes
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            switch try container.decode(String.self, forKey: .itemType){
            case Unassociated.tune.rawValue: self = .tune(try container.decode(AbcTune.self, forKey: .attributes))
            case Unassociated.tuneSet.rawValue: self = .tuneSet(try container.decode(AbcTuneSet.self, forKey:  .attributes))
            default:
                fatalError("Unknown type")
            }
            
        }
        
        func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case .tune(let tune) :
                try container.encode(tune , forKey: .attributes)
            case .tuneSet(let tuneSet) :
                try container.encode(tuneSet , forKey: .attributes)
            }
            
            try container.encode(unassociated.rawValue, forKey: .itemType)
        }
        
    }
    
    required public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        self.createdDateTime = try container.decodeIfPresent(Date.self, forKey: .createdDateTime) ?? .now
        self.modifiedDateTime = try container.decodeIfPresent(Date.self, forKey: .modifiedDateTime) ?? .now
        self.items = try container.decodeIfPresent([AbcCollection.CollectionItem].self, forKey: .items) ?? [CollectionItem]()
    }
    
}
