//
//  ViewController.swift
//  Youtube
//
//  Created by NDS on 17/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
//    var videos: [Video] = {
//        
//        var channel1 = Channel.init(profileName: "UpinIpinBestAnimation", profileImage: "upin_ipin_profile")
//        var video1 = Video.init(title: "Upin Ipin Sing Along Gembira Bermain Bersama - Sama Kawan", thumbnailImageName: "upin_ipin", channel: channel1, numberOfViews: 2340987457, dateUpload: nil)
//        
//        var channel2 = Channel.init(profileName: "Gokusan Indonesia", profileImage: "goku_profile")
//        var video2 = Video.init(title: "Best Scene Naruto vs Goku", thumbnailImageName: "naruto", channel: channel2, numberOfViews: 2356789, dateUpload: nil)
//        
//        var channel3 = Channel.init(profileName: "Ultraman Official Video", profileImage: "ultraman_profile")
//        
//        var video3 = Video.init(title: "Ultraman King Gen 3th", thumbnailImageName: "ultraman", channel: channel3, numberOfViews: 344788893, dateUpload: nil)
//        return [video1, video2, video3]
//    }()
   
    let feedCellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    let titles = ["Home", "Trending", "Subscription", "Account"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    
        setupCollectionView()
        setupMenuBar()
        setupNavBarIcon()
    }
    
    
    func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.isPagingEnabled = true
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
    }
    
    func setupNavBarIcon() {
        
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMoreItem))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    @objc func handleSearch() {
        
    }
    
    lazy var settingLauncher: SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMoreItem() {
        settingLauncher.showSetting()
    }
    
    func showControllerForSetting(setting: Setting) {

        let dummySettingViewController = UIViewController()
        dummySettingViewController.view.backgroundColor = .white
        dummySettingViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar() {
    
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        
        view.addSubview(redView)
        _ = redView.anchor(nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        view.addSubview(menuBar)
        _ = menuBar.anchor(topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        setTitleForIndex(index: Int(index))
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarViewLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indetifier: String
        
        if indexPath.item == 1 {
            indetifier = trendingCellId
        } else if indexPath.item == 2 {
            indetifier = subscriptionCellId
        } else {
            indetifier = feedCellId
        }
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: indetifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

}




