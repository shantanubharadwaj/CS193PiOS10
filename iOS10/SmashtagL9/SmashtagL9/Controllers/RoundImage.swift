//
//  RoundImage.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 03/06/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation
import UIKit

class RoundImage: UIImageView{
    var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    // set border width
    var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    // set border color
    
    var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func awakeFromNib() {
        self.clipsToBounds = true
    }
}
