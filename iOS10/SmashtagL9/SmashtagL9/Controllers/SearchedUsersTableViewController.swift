//
//  SearchedUsersTableViewController.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 12/06/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit
import CoreData

class SearchedUsersTableViewController: FetchedResultsTableViewController {
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer { didSet { updateUI() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    var fetchedResultsController: NSFetchedResultsController<LocalUser>?
    
    private func updateUI() {
        if let context = container?.viewContext {
            let request: NSFetchRequest<LocalUser> = LocalUser.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            request.predicate = NSPredicate(format: "any age > %@ AND age < %@","25","35")
            fetchedResultsController = NSFetchedResultsController<LocalUser>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
            try? fetchedResultsController?.performFetch()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath)
        
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.selectionStyle = .none
        // Configure the cell...
        if let userInfo = fetchedResultsController?.object(at: indexPath){
            if let userCell = cell as? UserInfoTableViewCell {
                userCell.userInfo = userInfo
            }
        }
        return cell
    }
}
