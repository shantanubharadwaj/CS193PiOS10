//
//  TweetTableViewController.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 5/28/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController {
    
    private var users = [Array<User>]() {
        didSet {
            print("New user received : \(String(describing: users.first?.count))")
        }
    }
    
    @IBAction func clearItems(_ sender: UIBarButtonItem) {
        users.removeAll()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        searchUser()
    }
    
    func searchUser() {
        let request = UserRequest(count: 5)
        request.fetch { [weak self] response in
            if let newUsers = response {
                OperationQueue.main.addOperation {
                    self?.users.insert(newUsers, at: 0)
                    self?.tableView.insertSections([0], with: .fade)
                }
            }
//            if let users = response, users.isEmpty == false {
//                print("************USERS LIST*************")
//                print(users)
//            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return users.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)

        // Configure the cell...
        let user: User = users[indexPath.section][indexPath.row]
        if let userCell = cell as? UserTableViewCell {
            userCell.user = user
        }
        return cell
    }
    
}
