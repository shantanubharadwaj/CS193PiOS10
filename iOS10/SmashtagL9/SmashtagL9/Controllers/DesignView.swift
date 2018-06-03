//
//  DesignView.swift
//  SmashtagL9
//
//  Created by Shantanu Dutta on 03/06/18.
//  Copyright © 2018 Shantanu Dutta. All rights reserved.
//

import Foundation
import UIKit

class DesignView: UIView {
    var cornerRadius: CGFloat = 4
    var shadowColor: UIColor? = UIColor.black.withAlphaComponent(0.2)
    
    let shadowOffSetWidth: Int = 0
    let shadowOffSetHeight: Int = 1
    var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
}
