//
//  ViewController.swift
//  Spontaneous Fun
//
//  Created by i am awesome on 6/10/16.
//  Copyright © 2016 Super Awesome. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableViewContest: UITableView!
    
    let contestData:[Contest] = [
        Contest(title: "Ugliest Shuffle", artist: "Dada Life ⋆ Champagne Shower", votes: 59, thumbnail: UIImage(named:"dada-life")!, countdown: "4:00:00"),
        Contest(title: "Amazing Lights", artist: "Kaskade ⋆ Signed Hat", votes: 37, thumbnail: UIImage(named:"kaskade")!, countdown: "5:00:10"),
        Contest(title: "Emotional Totems", artist: "Flux Favillion ⋆ Launch the Bass Cannon", votes: 21, thumbnail: UIImage(named:"flux")!, countdown: "6:00:30"),
        Contest(title: "Illest Festival Flag", artist: "The Chainsmokers ⋆ Backstage Passes", votes: 133, thumbnail: UIImage(named:"chainsmokers")!, countdown: "6:30:30"),
        Contest(title: "Plurest Fam", artist: "Martin Garrix ⋆ VIP Experience", votes: 297, thumbnail: UIImage(named:"martin-garrix")!, countdown: "6:40:30"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewContest.delegate = self
        tableViewContest.dataSource = self
        tableViewContest.rowHeight = 60
        tableViewContest.estimatedRowHeight = 160.0
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Official Contest"
        } else if section == 1 {
            return "Live Contest"
        } else {
            return "Past Contest"
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contestData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contestcell", forIndexPath: indexPath) as! ContestCell
        
        cell.title.text = contestData[indexPath.row].title
        cell.artist.text = contestData[indexPath.row].artist
        cell.thumbnail.image = contestData[indexPath.row].thumbnail
        cell.votes.text = "\(contestData[indexPath.row].votes)"
        cell.countdown.text = contestData[indexPath.row].countdown
        
        //Make the thumbnail round
        cell.thumbnail.layer.cornerRadius = cell.thumbnail.frame.width / 2
        cell.thumbnail.layer.masksToBounds = true
        
        return cell
    }
    
}

