//
//  ItemChooserTableViewController.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-18.
//

import UIKit
internal import CoreData

class ItemChooserTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    lazy var fetchedResultController : NSFetchedResultsController<TDMSearchable>? = makeFetchedResultController()
    
    var selectedItem : TDMSearchable? = nil
    
    var delegate : ItemChooserDelegate? = nil
    
    func makeFetchedResultController()->NSFetchedResultsController<TDMSearchable>?{
        let context = AppDelegate.sharedDelegate.persistentContainer.viewContext
        
        let fetchRequest = TDMSearchable.fetchRequest()
        
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
        print("ItemPicker: ViewDidLoad ")
        title = "Choose an item"
        super.viewDidLoad()
        if let navigationController {
            navigationController.title = title
        }
        
        let doneAction = UIAction {_ in
            if let delegate = self.delegate {
                delegate.didCancel()
            } else {
                self.dismiss(animated: true)
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: doneAction)

        tableView.register(UITableViewCell.self , forCellReuseIdentifier: "reuseIdentifier")
        tableView.delegate = self
        tableView.dataSource = self

         _ = makeFetchedResultController()
        
        do {
            try fetchedResultController?.performFetch()
        } catch {
            fatalError("couldn't fetch")
        }
    

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
        selectedItem = fetchedResultController?.object(at: indexPath)
        if let delegate,
        let selectedItem {
            delegate.didSelect(selectedItem)
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
     

     //MARK: - fetchedResultsController delegate
     
     func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
         tableView.reloadData()
     }

}

protocol ItemChooserDelegate {
    func didSelect(_ item: TDMSearchable)
    
    func didCancel()
}
