//
//  V1_v2_Migration.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2026-09-15.
//

import Foundation
import CoreData
//@objc(V1_v2_Migration)

class V1_v2_Migration : NSEntityMigrationPolicy {
    @objc func uniqueId() -> NSString {
        UUID().uuidString as NSString
    }
}

