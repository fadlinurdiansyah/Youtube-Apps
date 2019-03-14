//
//  TrendingCell.swift
//  Youtube
//
//  Created by NDS on 23/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchTranding { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
        
}
