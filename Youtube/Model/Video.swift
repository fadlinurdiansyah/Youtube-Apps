//
//  Video.swift
//  Youtube
//
//  Created by NDS on 19/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class Video: NSObject {
    var title: String?
    var thumbnailImageName: String?
    var channel: Channel?
    var numberOfViews: NSNumber?
//    var dateUpload: NSDate? = nil
    var duration: Int?
}

class Channel: NSObject {
    var profileName: String?
    var profileImage: String?
}





