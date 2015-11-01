//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Anton Vasilyev on 10/27/15.
//  Copyright © 2015 Anton Vasilyev. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(url: NSURL, t: String) {
        filePathUrl = url
        title = t
    }
}