//
//  UserTableViewController.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 5/28/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    private var users = [Array<User>]() {
        didSet {
            print("New user received : \(String(describing: users.first?.count))")
        }
    }
    
    private var displayedUsers = [User]()
    
    @IBAction func clearItems(_ sender: UIBarButtonItem) {
        users.removeAll()
        displayedUsers.removeAll()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        searchUser()
        customiseRefreshControl()
    }
    
    internal func insertUser(_ newUsers: [User]) {
        self.users.insert(newUsers, at: 0)
        self.tableView.insertSections([0], with: .fade)
    }
    
    func searchUser() {
        let request = UserRequest(count: 15)
        OperationQueue.main.addOperation {
            if !UIApplication.shared.isNetworkActivityIndicatorVisible {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
        request.fetch { [weak self] response in
            OperationQueue.main.addOperation {
                if UIApplication.shared.isNetworkActivityIndicatorVisible {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            if let newUsers = response {
                OperationQueue.main.addOperation {[weak self] in
                    self?.insertUser(newUsers)
                }
            }
        }
    }
    
    func customiseRefreshControl() {
        refreshControl?.tintColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        refreshControl?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        refreshControl?.attributedTitle = NSAttributedString(string: "Fetching new user...")
        refreshControl?.addTarget(self, action: #selector(UserTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        let request = UserRequest(count: 10)
        OperationQueue.main.addOperation {
            if !UIApplication.shared.isNetworkActivityIndicatorVisible {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
        request.fetch { [weak self] response in
            OperationQueue.main.addOperation {
                if UIApplication.shared.isNetworkActivityIndicatorVisible {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            if let newUsers = response {
                OperationQueue.main.addOperation {[weak self] in
                    self?.insertUser(newUsers)
                    refreshControl.endRefreshing()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if users.count > 0 {
            if let _ = tableView.backgroundView {
                tableView.backgroundView = nil
            }
            return users.count
        }else{
            // Displaying a message when the table is empty
            let messagelabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messagelabel.text = "No data is available. Please pull down to refresh."
            messagelabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            messagelabel.numberOfLines = 0
            messagelabel.textAlignment = .center
            var font = UIFont.preferredFont(forTextStyle: .body).withSize(20)
            font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
            messagelabel.font = font
            messagelabel.sizeToFit()
            
            tableView.backgroundView = messagelabel
            tableView.backgroundView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
            tableView.separatorStyle = .none
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.selectionStyle = .none
        // Configure the cell...
        let user: User = users[indexPath.section][indexPath.row]
        if let userCell = cell as? UserTableViewCell {
            userCell.user = user
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let user = users[indexPath.section][indexPath.row]
        if displayedUsers.contains(user) {
            return
        }
        // 1. Set the initial state of the cell
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        // 2. UIView animation method to change to the final state of the cell
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !users.isEmpty else { return }
        let user: User = users[indexPath.section][indexPath.row]
        displayedUsers.append(user)
    }
}
