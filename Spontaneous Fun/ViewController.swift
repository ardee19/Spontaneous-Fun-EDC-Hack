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
    
    @IBAction func addContest(sender: UIButton) {
        JLToast.makeText("Yeah Fam").show()
    }
    let contestData:[Contest] = [
        Contest(title: "Ugliest Banana", artist: "Dada Life · Champagne Shower", votes: 59, thumbnail: UIImage(named:"dada-life")!, countdown: "4:00:00"),
        Contest(title: "Air DJ Battle", artist: "Kaskade · Signed Hat", votes: 37, thumbnail: UIImage(named:"kaskade")!, countdown: "5:00:10"),
        Contest(title: "Emotional Totems", artist: "Flux Favillion · Launch the Bass Cannon", votes: 21, thumbnail: UIImage(named:"flux")!, countdown: "6:00:30"),
        Contest(title: "Lit Festival Flags", artist: "The Chainsmokers · Backstage Passes", votes: 133, thumbnail: UIImage(named:"chainsmokers")!, countdown: "6:30:30"),
        Contest(title: "Plurest Fam Photo", artist: "Martin Garrix · VIP Experience", votes: 297, thumbnail: UIImage(named:"martin-garrix")!, countdown: "6:40:30"),
    ]
    
    let userContestData:[Contest] = [
        Contest(title: "Popping it Deep down low", artist: "Chasity", votes: 21, thumbnail: UIImage(named:"avatar-12")!, countdown: ""),
        Contest(title: "Under the Electric Sky", artist: "Alchemy", votes: 84, thumbnail: UIImage(named:"avatar-11")!, countdown: ""),
        Contest(title: "Ayyyyy", artist: "Rave Unicorn", votes: 5, thumbnail: UIImage(named:"avatar-10")!, countdown: ""),
        Contest(title: "Hardcore raving", artist: "Cinnamon", votes: 133, thumbnail: UIImage(named:"avatar-9")!, countdown: ""),
        Contest(title: "Epic Moves", artist: "Kirsten", votes: 297, thumbnail: UIImage(named:"avatar-8")!, countdown: ""),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableViewContest.delegate = self
        tableViewContest.dataSource = self
        
        // N-01 Table Separator
        tableViewContest.separatorColor = Palette.OUTLINE
        
        // Set automatic table row height
        tableViewContest.estimatedRowHeight = 78.0;
        tableViewContest.rowHeight = UITableViewAutomaticDimension;
        
        // Remove extra separator
        tableViewContest.tableFooterView = UIView()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == Segue.contestDetails {
            let contestDetailsViewController = segue.destinationViewController as!ContestDetailsViewController
            contestDetailsViewController.contest = selectedContest
        }
        

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 20))
        /* Create custom view to display section header... */
        let label: UILabel = UILabel(frame: CGRectMake(10, 5, tableView.frame.size.width, 20))
        label.font = UIFont(name: "AvenirNext-Heavy", size: 13)
        label.textColor = UIColor(red: 233/255.0, green: 6/255.0, blue: 250/255.0, alpha: 1.0)

//        label.font = UIFont.boldSystemFontOfSize(12)
        
        var string: String
        
        if section == 0 {
            string = "OFFICIAL CONTESTS"
        } else if section == 1 {
            string = "LIVE CONTESTS"
        } else {
            string = "PAST CONTESTS"
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
        
        
//        cell.title.text = contestData[indexPath.row].title
//        cell.artist.text = contestData[indexPath.row].artist
//        cell.thumbnail.image = contestData[indexPath.row].thumbnail
//        cell.votes.text = "\(contestData[indexPath.row].votes)"
//        cell.countdown.text = contestData[indexPath.row].countdown
        
        if indexPath.section == 0 {
            cell.title.text = contestData[indexPath.row].title
            cell.artist.text = contestData[indexPath.row].artist
            cell.thumbnail.image = contestData[indexPath.row].thumbnail
            cell.votes.text = "\(contestData[indexPath.row].votes)"
            cell.countdown.text = contestData[indexPath.row].countdown
        } else if indexPath.section == 1 {
            cell.title.text = userContestData[indexPath.row].title
            cell.artist.text = userContestData[indexPath.row].artist
            cell.thumbnail.image = userContestData[indexPath.row].thumbnail
            cell.votes.text = "\(userContestData[indexPath.row].votes)"
            cell.countdown.text = userContestData[indexPath.row].countdown
        } else {
            cell.title.text = userContestData[indexPath.row].title
            cell.artist.text = userContestData[indexPath.row].artist
            cell.thumbnail.image = userContestData[indexPath.row].thumbnail
            cell.votes.text = "\(userContestData[indexPath.row].votes)"
            cell.countdown.text = userContestData[indexPath.row].countdown
        }
        
        //Make the thumbnail round
        cell.thumbnail.layer.cornerRadius = cell.thumbnail.frame.width / 2
        cell.thumbnail.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            selectedContest = contestData[indexPath.row]
        } else if indexPath.section == 1 {
            selectedContest = userContestData[indexPath.row]
        } else {
            selectedContest = contestData[indexPath.row]
        }
        
        
        
        self.performSegueWithIdentifier("contestDetails", sender: nil)
    }
    
}

