//
//  UserInfoTableViewCell.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 12/06/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: RoundImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userNationality: UILabel!
    
    var userInfo: LocalUser? { didSet { updateUI() }}
    
    func updateUI() {
        if let name = userInfo?.name{
            userName.text = name
        }else{
            userName.text = "Anonymous"
        }
        
        if let age = userInfo?.age{
            userAge.text = String(age)
        }else{
            userAge.text = ""
        }
        
        if let nat = userInfo?.country{
            userNationality.text = nat
        }else{
            userNationality.text = ""
        }
        
        if let url = userInfo?.image {
            let request = ImageRequest(url: url)
            request.fetch {[weak self] dlImage in
                if let image = dlImage{
                    OperationQueue.main.addOperation {
                        self?.userImage.image = image
                    }
                }
            }
        }else{
            userImage?.image = UIImage(named: "defaultUser")
        }
        
        updateImageView()
    }
    
    func updateImageView() {
        userImage.cornerRadius = userImage.frame.size.width / 2
        userImage.borderWidth = 2.0
        userImage.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
