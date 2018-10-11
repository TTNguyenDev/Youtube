//
//  ApiService.swift
//  Youtube
//
//  Created by TT Nguyen on 10/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideosForFeedCell(completion: @escaping ([Video]) -> ()) {
        fetchVideos(urlString: baseUrl + "/home.json", completion: completion)
    }
    
    func fetchVideosForTrendingCell(completion: @escaping ([Video]) -> ()) {
        fetchVideos(urlString: baseUrl + "/trending.json", completion: completion)
    }
    
    func fetchVideosForSubscriptionsCell(completion: @escaping ([Video]) -> ()) {
        fetchVideos(urlString: baseUrl + "/subscriptions.json", completion: completion)
    }
    
    func fetchVideos(urlString: String, completion: @escaping ([Video]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            do {
                let videoNeedToFetch = try JSONDecoder().decode([Video].self, from: data)
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(videoNeedToFetch)
                })
            } catch let jsonError {
                print(jsonError)
            }
        }).resume()
    }
}
