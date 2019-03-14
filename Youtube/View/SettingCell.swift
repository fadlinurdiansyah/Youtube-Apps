//
//  SettingCell.swift
//  Youtube
//
//  Created by NDS on 22/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    var setting : Setting? {
        
        didSet {
            
            if let name = setting?.name.rawValue {
                settingNameLabel.text = name
            }
            
            if let image = setting?.image {
                settingImageView.image = UIImage(named: image)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            }
        }
    }
    
    let settingNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let settingImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "settings")
        iv.tintColor = UIColor.darkGray
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
//        backgroundColor = .red
        
        addSubview(settingImageView)
        addSubview(settingNameLabel)
        
        
        
        _ = settingImageView.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        settingImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        _ = settingNameLabel.anchor(settingImageView.topAnchor, left: settingImageView.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        settingNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
    
    
    override var isHighlighted: Bool {
        
        didSet {
            
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
            settingNameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            settingImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
}
