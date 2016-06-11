//
//  Contest.swift
//  Spontaneous Fun
//
//  Created by i am awesome on 6/10/16.
//  Copyright © 2016 Super Awesome. All rights reserved.
//

import Foundation
import UIKit

struct  Contest {
    let title: String?
    let artist: String?
    var votes: Int!
    let thumbnail:UIImage?
    var countdown: String?
    
    init(title:String, artist:String, votes:Int, thumbnail:UIImage, countdown:String) {
        self.title = title.capitalizedString
        self.artist = artist
        self.votes = votes
        self.thumbnail = thumbnail
        self.countdown = countdown
    }
}
