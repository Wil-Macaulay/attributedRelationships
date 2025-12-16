//
//  CollectionsTableViewController.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-15.
//

import UIKit
import CoreData

class CollectionsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var fetchedResultController : NSFetchedResultsController<TDMCollection>? = nil
    
    func makeFetchedResultController()->NSFetchedResultsController<TDMCollection>?{
        let context = AppDelegate.sharedDelegate.persistentContainer.viewContext
        
        let fetchRequest = TDMCollection.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "displayName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultController?.delegate = self
        return fetchedResultController
            
        
    }
    override func viewDidLoad() {
        print("CollectionsTableViewController: ViewDidLoad ")
        title = "Collections"
        super.viewDidLoad()
        if let navigationController {
            navigationController.title = title
        }
        
        self.tableView.register(UITableViewCell.self , forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        _ = makeFetchedResultController()
        
        do {
            try fetchedResultController?.performFetch()
        } catch {
            fatalError("couldn't fetch")
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultController?.sections?[section] else {
             return 0
         }
         
         return sectionInfo.numberOfObjects
     }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        // Configure the cell...
        let item = fetchedResultController?.object(at: indexPath)
        cell.textLabel?.text = item?.displayName

        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = (fetchedResultController?.object(at: indexPath))!
        let collectionVC = CollectionViewController()
        collectionVC.detailItem = item
        showDetailViewController(collectionVC, sender: self)
 
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
