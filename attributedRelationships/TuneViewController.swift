//
//  TuneViewController.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//

import UIKit


class TuneViewController: UIViewController {
    
    @IBOutlet weak var displayNameField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var createdField: UITextField!
    @IBOutlet weak var modifiedField: UITextField!
    
    var detailItem : TDMTune? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lockFields()
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftItemsSupplementBackButton = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFields()
    }
 
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            unlockFields()
        } else {
            updateItem()
            lockFields()
            updateFields()
        }
        
    }


    func lockFields (){
        displayNameField.isEnabled = false
        notesField.isEnabled = false
        createdField.isEnabled = false
        modifiedField.isEnabled = false
    }
    
    func unlockFields() {
        displayNameField.isEnabled = true
        notesField.isEnabled = true
    }
    
    func updateFields() {
        displayNameField.text = ""
        notesField.text = ""
        createdField.text = ""
        modifiedField.text = ""

        if let detailItem {
            displayNameField.text = detailItem.displayName
            notesField.text = detailItem.notes
            createdField.text = detailItem.createdDateTime?.formatted()
            modifiedField.text = detailItem.modifiedDateTime?.formatted()
        }
    }
    
    func updateItem() {
        detailItem?.displayName = displayNameField.text
        detailItem?.notes = notesField.text
        detailItem?.modifiedDateTime = Date()
    }
    
    


}
