//
//  ViewController.swift
//  Spontaneous Fun
//
//  Created by i am awesome on 6/10/16.
//  Copyright © 2016 Super Awesome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewContest: UITableView!
    
    var selectedContest = Contest()
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == Segue.contestDetails {
            let contestDetailsViewController = segue.destinationViewController as!ContestDetailsViewController
            contestDetailsViewController.contest = selectedContest
        }
        

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        let view: UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
        /* Create custom view to display section header... */
        let label: UILabel = UILabel(frame: CGRectMake(10, 5, tableView.frame.size.width, 18))
        label.font = UIFont(name: "AvenirNext-Heavy", size: 11)
        label.textColor = UIColor(red: 233/255.0, green: 6/255.0, blue: 250/255.0, alpha: 1.0)

//        label.font = UIFont.boldSystemFontOfSize(12)
        
        var string: String
        
        if section == 0 {
            string = "OFFICIAL CONTEST"
        } else if section == 1 {
            string = "LIVE CONTEST"
        } else {
            string = "PAST CONTEST"
        }
        
        /* Section header is in 0th index... */
        label.text = string
        print(string)
        view.addSubview(label)
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //your background color...
        return view
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        if section == 0 {
//            return "Official Contest"
//        } else if section == 1 {
//            return "Live Contest"
//        } else {
//            return "Past Contest"
//        }
//        
//        
//    }
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedContest = contestData[indexPath.row]
        self.performSegueWithIdentifier("contestDetails", sender: nil)
    }
    
}

