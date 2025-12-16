//
//  TDMCollection+test.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-15.
//

import Foundation
import CoreData

extension TDMCollection {
    class func makeInstance(context: NSManagedObjectContext, displayName:String, notes:String? = nil) ->  TDMCollection {
        let now = Date()
        let newInstance = Self.init(context: context)
        newInstance.displayName = displayName
        newInstance.createdDateTime = now
        newInstance.modifiedDateTime = now
        return newInstance
    }
    

}
