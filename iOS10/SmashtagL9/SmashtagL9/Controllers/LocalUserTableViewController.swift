//
//  LocalUserTableViewController.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 12/06/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit
import CoreData

class LocalUserTableViewController: UserTableViewController {
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func insertUser(_ newUsers: [User]) {
        super.insertUser(newUsers)
        updateDataBase(with: newUsers)
    }
    
    private func updateDataBase(with users: [User]) {
        container?.performBackgroundTask { [weak self] context in
            for userInfo in users {
                _ = try? LocalUser.findOrCreateUser(matching: userInfo, in: context)
            }
            try? context.save()
            self?.printDatabaseStatistics()
        }
    }
    
    private func printDatabaseStatistics() {
        if let context = container?.viewContext {
//            if let userCount = (try? context.fetch(LocalUser.fetchRequest()))?.count {
//                print("\(userCount) Users")
//            }
            context.perform {
                if let userCount = try? context.count(for: LocalUser.fetchRequest()) {
                    print("\(userCount) Local Users")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Users short detail searched" {
            if let userInfoTableVC = segue.destination as? SearchedUsersTableViewController {
                userInfoTableVC.container = container
            }
        }
    }
}
