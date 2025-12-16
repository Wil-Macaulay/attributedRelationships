//
//  TuneSetViewController.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//

import UIKit

class TuneSetViewController: UIViewController {

    @IBOutlet weak var displayNameField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var createdField: UITextField!
    @IBOutlet weak var modifiedField: UITextField!
    @IBOutlet weak var tunesStackView: UIStackView!
    
    var detailItem : TDMTuneSet? = nil

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
        if let tunesStackView {
            for subview in tunesStackView.arrangedSubviews {
                tunesStackView.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        }

        if let detailItem {
            displayNameField.text = detailItem.displayName
            notesField.text = detailItem.notes
            createdField.text = detailItem.createdDateTime?.formatted()
            modifiedField.text = detailItem.modifiedDateTime?.formatted()
            if let tunes = detailItem.tunes {
                for tune in tunes {
                    if let tune = tune as? TDMTune {
                        let tuneLabel = UILabel()
                        tuneLabel.text = tune.displayName
                        tunesStackView.addArrangedSubview(tuneLabel)
                    }
                }
            }

        }
    }
    
    func updateItem() {
        detailItem?.displayName = displayNameField.text
        detailItem?.notes = notesField.text
        detailItem?.modifiedDateTime = Date()
    }


}
