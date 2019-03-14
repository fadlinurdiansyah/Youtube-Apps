//
//  MenuBar.swift
//  Youtube
//
//  Created by NDS on 18/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    private let menuBarCellId = "menuBarrCellId"
    let imageNames = ["home","trending","subscriptions","account"]
    var homeController: HomeController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        layout.scrollDirection = .horizontal
        return cv
    }()
    
    let horizontalBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return view
    }()
    
    var horizontalBarViewLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(horizontalBarView)

        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuBarCellId)
        
        _ = collectionView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
      
        horizontalBarViewLeftAnchor = horizontalBarView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 4).first
        horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4).isActive = true
        
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        DispatchQueue.main.async {
            self.collectionView.selectItem(at: selectedIndexPath, animated: false
                , scrollPosition: [])
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        horizontalBarViewLeftAnchor?.constant = x
//        
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
//        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        homeController?.setTitleForIndex(index: indexPath.item)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuBarCellId, for: indexPath) as! MenuCell
        cell.menuImageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        cell.menuImageView.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
