//
//  ApiService.swift
//  Youtube
//
//  Created by NDS on 23/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json") { (videos) in
            completion(videos)
        }
        
    }
    
    
    func fetchTranding(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json") { (videos) in
            completion(videos)
        }
      
    }
    
    
    func fetchSubscription(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json") { (videos) in
            completion(videos)
        }
        
    }
    
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                
//                print(json)
                var videos = [Video]()
                
                for dict in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dict["title"] as? String
                    video.thumbnailImageName = dict["thumbnail_image_name"] as? String
                    video.numberOfViews = dict["number_of_views"] as? NSNumber
                    video.duration = dict["duration"] as? Int
                    
                    let channelDict = dict["channel"] as? [String: AnyObject]
                    
                    let channel = Channel()
                    channel.profileName = channelDict?["name"] as? String
                    channel.profileImage = channelDict?["profile_image_name"] as? String
                    
                    video.channel = channel
                    videos.append(video)
                    
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                }
                
                
            } catch let jsonError {
                print(jsonError)
                
            }
            }.resume()
        
    }
    

}
