//
//  CollectionViewController.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-15.
//

import UIKit
import CoreData

class CollectionViewController: UITableViewController {
    
    var detailItem : TDMCollection? = nil

    override func viewDidLoad() {
        print("CollectionViewController: ViewDidLoad ")
        title = "Collection"
        super.viewDidLoad()
        if let navigationController {
            navigationController.title = title
        }
        
        self.tableView.register(UITableViewCell.self , forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let detailItem {
            title = detailItem.displayName
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
