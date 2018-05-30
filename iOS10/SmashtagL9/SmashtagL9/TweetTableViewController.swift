//
//  TweetTableViewController.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 5/28/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)

        // Configure the cell...
 
        return cell
    }
    
}
