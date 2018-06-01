//
//  UserTableViewCell.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 01/06/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var user: User? { didSet { updateUI() } }
    
    private func updateUI() {
        if let name = user?.userName {
            let fullName = name.title.localizedCapitalized + " " + name.firstName.localizedCapitalized + " " + name.lastName.localizedCapitalized
            userNameLabel?.text = fullName
        }else{
            userNameLabel?.text = "Anonymous"
        }
        
        if let userImage = user?.picture {
            let request = ImageRequest(url: userImage.largeImageURL)
            request.fetch {[weak self] dlImage in
                if let image = dlImage{
                    OperationQueue.main.addOperation {
                        self?.userImageView.image = image
                    }
                }
            }
        }else{
            userImageView?.image = nil
        }
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
