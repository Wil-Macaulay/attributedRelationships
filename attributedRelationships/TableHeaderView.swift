//
//  TableHeaderView.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-19.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var displayNameField : UITextField!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var createdField : UITextField!
    @IBOutlet weak var modifiedField : UITextField!
    
    
//    init(){
//        super.init(reuseIdentifier: nil)
////        displayNameField = UITextField()
////        createdField = UITextField()
////        modifiedField = UITextField()
////          stackView = UIStackView(arrangedSubviews: [
////            field(displayNameField!, labeled: "Name"),
////            field(createdField!, labeled: "Created Date"),
////            field(modifiedField!, labeled: "Modified Date")
////            
////        ])
////        stackView?.axis = .vertical
//        self.adjustConstraints()
//        
//    }
    
    func field(_ field : UITextField, labeled : String) -> UIStackView {
        let labelView = UILabel()
        labelView.text = labeled
        let stackView = UIStackView(arrangedSubviews: [
            labelView,field
        ])
        stackView.axis  = .horizontal
        stackView.distribution = .fillEqually
        return stackView
        
    }
    
    
    func adjustConstraints(){
        if let stackView {
            contentView.addSubview(stackView)
            let margins = contentView.layoutMarginsGuide
            //print("content view margins \(margins.widthAnchor), \(margins.heightAnchor)")
            stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            stackView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 1.0).isActive = true
            stackView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0).isActive = true
        }
    }
    
    func lockFields(){
        displayNameField.isEnabled = false
        createdField.isEnabled = false
        modifiedField.isEnabled = false
    }
    func unlockFields(){
        displayNameField.isEnabled = true
    }

    func updateFields(displayName : String?, createdDate : Date?, modifiedDate : Date?) {
        displayNameField?.text = ""
        createdField?.text = ""
        modifiedField?.text = ""
        
        if let displayName {
            displayNameField?.text = displayName
        }
        if let createdDate {
            createdField?.text = createdDate.formatted()
        }
        if let modifiedDate {
            modifiedField?.text = modifiedDate.formatted()
        }
        self.invalidateIntrinsicContentSize()
    }
}
