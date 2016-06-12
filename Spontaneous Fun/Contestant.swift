//
//  Contestants.swift
//  Spontaneous Fun
//
//  Created by i am awesome on 6/11/16.
//  Copyright © 2016 Super Awesome. All rights reserved.
//

import Foundation
import UIKit

struct Contestant {
    let avatar:UIImage?
    let videoSubmission:AnyObject?
    let imageSubmission:UIImage?
    var score:Int = 0
    
    init(avatar:UIImage, video:AnyObject?, imageSubmission:UIImage?, score:Int?) {
        self.avatar = avatar
        self.videoSubmission = video
        self.imageSubmission = imageSubmission
        if let yesScore = score {
            self.score = yesScore
        }
        
    }
}
