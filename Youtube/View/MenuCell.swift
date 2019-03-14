//
//  MenuCell.swift
//  Youtube
//
//  Created by NDS on 18/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let menuImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    
    override var isSelected: Bool {
        didSet {
            menuImageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            menuImageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        
        addSubview(menuImageView)
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        
        _ = menuImageView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 25, rightConstant: 0, widthConstant: 28, heightConstant: 28)
        menuImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        menuImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
   
        
        
    }
}
