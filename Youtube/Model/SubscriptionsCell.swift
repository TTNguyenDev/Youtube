//
//  SubscriptionsCell.swift
//  Youtube
//
//  Created by TT Nguyen on 10/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class SubscriptionsCell: FeedCell {
    override func fetchVideo() {
        ApiService.sharedInstance.fetchVideosForSubscriptionsCell { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
