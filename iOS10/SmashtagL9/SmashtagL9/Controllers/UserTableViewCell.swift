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
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var nationality: UILabel!
    
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var bckImageView: RoundImage!
    
//    @IBOutlet weak var backgroundCardView: DesignView!
    
    var user: User? { didSet { updateUI() } }
    
    private func updateUI() {
        if let name = user?.userName {
            let fullName = name.firstName.localizedCapitalized
            userNameLabel?.text = fullName
            if let age = user?.age, age != 0{
                ageLabel?.text = ", " + "\(age)"
            }
        }else{
            userNameLabel?.text = "Anonymous"
        }
        
        var previousValueShown = false
        
        if let city = user?.location.city, !city.isEmpty {
            cityLabel.text = city
            previousValueShown = true
        }else{
            cityLabel.isHidden = true
        }
        
        if let state = user?.location.state, !state.isEmpty {
            stateLabel.text = (previousValueShown ? ", " : "") + state
            previousValueShown = true
        }else{
            stateLabel.isHidden = true
        }
        
        if let nat = user?.nationality, !nat.isEmpty {
            nationality.text = (previousValueShown ? ", " : "") + nat
        }else{
            nationality.isHidden = true
        }
        
        previousValueShown = false
        
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
            userImageView?.image = UIImage(named: "defaultUser")
        }
        
        formatImageView()
        updateCellView()
        updateBckImageView()
    }
    
    private func formatImageView(){
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.layer.masksToBounds = true
        userImageView.clipsToBounds = true
        
        userImageView.layer.borderWidth = 3.0
        userImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    private func updateCellView() {
//        bckImageView.isHidden = true
        backgroundCardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        backgroundCardView.layer.cornerRadius = 5.0
        backgroundCardView.layer.masksToBounds = false
        
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        backgroundCardView.layer.shadowOpacity = 0.8
    }
    
    private func updateBckImageView() {
        bckImageView.cornerRadius = backgroundCardView.layer.cornerRadius
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
