//
//  LeafViewController.swift
//  tabbartest
//
//  Created by wil macaulay on 2025-11-07.
//

import UIKit

var title : String? = "Leaf"

class LeafViewController : UIViewController {
    
    
    override func viewDidLoad() {
        print("LeafViewController: viewDidLoad with title \(title ?? "<unassigned>")")
        if let navigationController {
            navigationController.title = title
        }
        
    }
}
