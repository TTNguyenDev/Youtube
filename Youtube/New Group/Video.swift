//
//  Video.swift
//  Youtube
//
//  Created by TT Nguyen on 10/3/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
