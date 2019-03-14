//
//  SettingLauncher.swift
//  Youtube
//
//  Created by NDS on 21/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit


class Setting: NSObject {
    var name: SettingName
    var image: String
    
    init(name: SettingName, image: String) {
        self.name = name
        self.image = image
    }
}

class SettingLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    let settingCellId = "settingCellId"
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    var homeController: HomeController?
    let cellHeight: CGFloat = 50
    let settings: [Setting] = {

       return [
        Setting(name: SettingName.Settings, image: "settings"),
        Setting(name: SettingName.TermPolicy, image: "privacy"),
        Setting(name: SettingName.SendFeedBack, image: "feedback"),
        Setting(name: SettingName.Help, image: "help"),
        Setting(name: SettingName.SwitchAccount, image: "switch_account"),
        Setting(name: SettingName.Cancel, image: "cancel")
        ]

    }()
    
    func showSetting() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissLauncView)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let count =  CGFloat(settings.count)
            let height: CGFloat = cellHeight * count
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
            
            
        }
    }
    
    
    @objc func dismissLauncView() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }, completion: nil)
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
//            self.blackView.alpha = 0
//            if let window = UIApplication.shared.keyWindow {
//                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//                }
//        }
//            
    }

            
    func handleDismiss(setting: Setting) {
        
        if setting.name != .Cancel {
            self.homeController?.showControllerForSetting(setting: setting)
        }
        dismissLauncView()
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingCellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }
    
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: settingCellId)
        
    }
}
