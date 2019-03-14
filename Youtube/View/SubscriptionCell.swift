//
//  SubscriptionCell.swift
//  Youtube
//
//  Created by NDS on 23/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscription { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
