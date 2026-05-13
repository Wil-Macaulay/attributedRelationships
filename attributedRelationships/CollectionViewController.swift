//
//  CollectionViewController.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-15.
//

import UIKit
import CoreData

class CollectionViewController: UITableViewController, ItemChooserDelegate {
    var chooser : ItemChooserTableViewController? = nil
    
    @IBOutlet weak var tableHeader: TableHeaderView!
    
    var detailItem : TDMCollection? = nil
    lazy var context = AppDelegate.sharedDelegate.persistentContainer.viewContext

    override func viewDidLoad() {
        print("CollectionViewController: ViewDidLoad ")
        title = "Collection"
        super.viewDidLoad()
        if let navigationController {
            navigationController.title = title
        }
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftItemsSupplementBackButton = true;
        let addAction = UIAction{_ in
            self.pickItem()
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
        navigationItem.leftBarButtonItem?.isHidden = true



        self.tableView.register(UITableViewCell.self , forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.tableHeaderView = tableHeader
        tableHeader.adjustConstraints()
        tableHeader.lockFields()

    }
    
    func pickItem(){
        
        chooser = ItemChooserTableViewController()
        chooser?.delegate = self
        present(chooser!, animated: true)
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            updateFields()
                    
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationItem.leftBarButtonItem?.isHidden = !editing
        if (editing) {
            tableHeader.unlockFields()
        } else {
            updateItem()
            tableHeader.lockFields()
            updateFields()
            do {
                try context.save()
            } catch {
                print("can't save")
            }
            tableHeader.lockFields()
        }

    }
    
    func updateItem() {
        if let detailItem {
            detailItem.displayName = tableHeader.displayNameField.text
            detailItem.modifiedDateTime = Date()
        }
    }
    
    // MARK: - Table header
    
    func updateFields () {
        if let detailItem  {
            tableHeader.updateFields(displayName: detailItem.displayName, createdDate: detailItem.createdDateTime, modifiedDate: detailItem.modifiedDateTime)
            title = "Collection: " + (detailItem.displayName ?? "<Untitled>")
       }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let detailItem,
           let count = detailItem.items?.count {
            return count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionTuneCell", for: indexPath)
        // Configure the cell...
        if let detailItem,
           let item = detailItem.items?[indexPath.row] as? TDMSearchable,
           let itemName = item.displayName {
            cell.textLabel?.text = itemName
        } else {
            cell.textLabel?.text = "-"
        }

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let detailItem {
           let item = detailItem.items?[indexPath.row]
            if let item = item as? TDMTune {
                showTuneVC(item: item)
            } else {
                if let item = item as? TDMTuneSet {
                    showTuneSetVC(item: item)
                }
            }

        }
    }
    
    func showTuneSetVC(item : TDMTuneSet){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = mainStoryboard.instantiateViewController(withIdentifier: "TuneSetViewController") as! TuneSetViewController
        detail.detailItem = item
        showDetailViewController(detail, sender: self)
    }


    func showTuneVC(item : TDMTune){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = mainStoryboard.instantiateViewController(withIdentifier: "TuneViewController") as! TuneViewController
        detail.detailItem = item
        showDetailViewController(detail, sender: self)

    }

 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let detailItem {
                detailItem.removeFromItems(at: indexPath.row)
                detailItem.modifiedDateTime = Date()
                let context = AppDelegate.sharedDelegate.persistentContainer.viewContext
                do {
                    try context.save()
                } catch {
                    print("can't save")
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if let detailItem,
           let item =  detailItem.items?.object(at: fromIndexPath.row) as? TDMSearchable {
            detailItem.removeFromItems(at: fromIndexPath.row)
            detailItem.insertIntoItems(item, at: to.row)
            tableView.reloadData()
        }

    }
    
    //MARK: - chooser protocol
    
    func didSelect(_ item: TDMSearchable) {
        print("item selected from chooser")
        
        detailItem?.addToItems(item)
        detailItem?.modifiedDateTime = Date()
        do {
            try context.save()
        } catch {
            print("can't save")
        }
        self.tableView.reloadData()
        dismiss(animated: true)
    }
    
    func didCancel() {
        print("chooser canceled")
        dismiss(animated: true)
    }
    


}
