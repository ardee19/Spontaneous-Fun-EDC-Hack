//
//  ContestDetailsViewController.swift
//  Spontaneous Fun
//
//  Created by i am awesome on 6/11/16.
//  Copyright © 2016 Super Awesome. All rights reserved.
//

import UIKit

class ContestDetailsViewController: UIViewController {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var contestTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    
    var contest:Contest = Contest()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(contest)
        
        thumbnail.image = contest.thumbnail
        votes.text = "\(contest.votes)"
        contestTitle.text = contest.title
        artist.text = contest.artist
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinTapped(sender: UIButton) {
        self.performSegueWithIdentifier(Segue.joinContest, sender: nil)
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == Segue.joinContest {
            let destination = segue.destinationViewController as! JoinViewController
            destination.contest = contest
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
