//
//  TrendingCell.swift
//  Youtube
//
//  Created by TT Nguyen on 10/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideo() {
        ApiService.sharedInstance.fetchVideosForTrendingCell { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
