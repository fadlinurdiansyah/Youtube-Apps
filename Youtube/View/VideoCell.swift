//
//  VideoCell.swift
//  Youtube
//
//  Created by NDS on 18/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var videos: Video? {
        didSet {
            
            titleLabel.text = videos?.title
            
    
            setupProfileImage()
            
            setupThumbnailImage()
            
            if let profileName = videos?.channel?.profileName, let numberOfViews = videos?.numberOfViews {
                
                let numberFormat = NumberFormatter()
                numberFormat.numberStyle = .decimal
                
                let subtitleText = "\(profileName) • \(numberFormat.string(from: numberOfViews)!) • 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            
            if let title = videos?.title {
                
                let size = CGSize(width: frame.width - 16 - 44 - 5 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.height > 20 {
                    titleLabelNSLayoutHeightConstrain?.constant = 44
                } else {
                    titleLabelNSLayoutHeightConstrain?.constant = 20
                }
                
            }
        }
    }
    
    
    func setupProfileImage() {
        
        if let profileImageUrl = videos?.channel?.profileImage {
            profileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    
    }
    
    func setupThumbnailImage() {
        if let thumnailImageUrl = videos?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumnailImageUrl)
        }
    }
    
    
    let thumbnailImageView: CustomeImageView = {
        let iv = CustomeImageView()
//        iv.image = UIImage(named: "upin_ipin")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let profileImageView: CustomeImageView = {
        let iv = CustomeImageView()
        iv.image = UIImage(named: "upin_ipin_profile")
        iv.backgroundColor = .green
        iv.layer.cornerRadius = 22
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //        label.backgroundColor = .red
        label.text = "Upin Ipin Sing Along Gembira Bermain"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let tv = UITextView()
        //        tv.backgroundColor = .purple
        tv.text = "UpinIpinBestAnimation - 1,345,876,876 views - 2 years ago"
        tv.textColor = .lightGray
        tv.isEditable = false
        tv.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return tv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var titleLabelNSLayoutHeightConstrain: NSLayoutConstraint?

    override func setupViews() {
        
        backgroundColor = .white
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        
        _ = thumbnailImageView.anchor(topAnchor, left: leftAnchor, bottom: profileImageView.topAnchor, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 5, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        _ = profileImageView.anchor(nil, left: thumbnailImageView.leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 36, rightConstant: 0, widthConstant: 44, heightConstant: 44)
        
        titleLabelNSLayoutHeightConstrain = titleLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: thumbnailImageView.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)[3]
        
        _ = subtitleTextView.anchor(titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: thumbnailImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        _ = separatorView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
        
    }
    
}
