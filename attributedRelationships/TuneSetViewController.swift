//
//  TuneSetViewController.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-14.
//

import UIKit
internal import CoreData

class TuneSetViewController: UIViewController, ItemChooserDelegate {

    @IBOutlet weak var displayNameField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var createdField: UITextField!
    @IBOutlet weak var modifiedField: UITextField!
    @IBOutlet weak var tunesStackView: UIStackView!
    
    var detailItem : TDMTuneSet? = nil
    lazy var context  = AppDelegate.sharedDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lockFields()
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftItemsSupplementBackButton = true;
        let addAction = UIAction{_ in
            self.pickItem()
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)

    }
    
    func pickItem(){
        
        let chooser = ItemChooserTableViewController()
        chooser.delegate = self
        present(chooser, animated: true)

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFields()
     }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationItem.leftBarButtonItem?.isHidden = !editing

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
            title = "Set: " + (detailItem.displayName ?? "<untitled>")
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
        do {
            try context.save()
        } catch {
            print("can't save")
        }

    }
    
    //MARK: - chooser protocol
    
    func didSelect(_ item: TDMSearchable) {
        print("item selected from chooser")
        if let item = item as? TDMTune {
            detailItem?.addToTunes(item)
            detailItem?.modifiedDateTime = Date()
            do {
                try context.save()
            } catch {
                print("can't save")
            }
            updateFields()
        }
        dismiss(animated: true)
    }
    
    func didCancel() {
        print("chooser canceled")
        dismiss(animated: true)
    }



}
