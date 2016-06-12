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
    

    @IBOutlet weak var scrollview: UIScrollView!
    
    var contest:Contest = Contest()
    
    @IBOutlet weak var imageDance: UIImageView!
    
    var selectedContestant = Contestant() {
        didSet {
            if let image = selectedContestant.imageSubmission {
                imageDance.image = image
            }
        }
    }
    

    var totalScrollwidth = 376 {
        didSet {
            self.scrollview.contentSize = CGSizeMake(CGFloat(totalScrollwidth), 60)
        }
    }
    
    public var contestants = [
        Contestant(avatar: UIImage(named:"avatar-1")!, video: nil, imageSubmission: UIImage(named:"totem-1"), score: 10),
        Contestant(avatar: UIImage(named:"avatar-2")!, video: nil, imageSubmission: UIImage(named:"totem-2"), score: 20),
        Contestant(avatar: UIImage(named:"avatar-3")!, video: nil, imageSubmission: UIImage(named:"totem-3"), score: 30),
        Contestant(avatar: UIImage(named:"avatar-4")!, video: nil, imageSubmission: UIImage(named:"totem-4"), score: 40),
        Contestant(avatar: UIImage(named:"avatar-5")!, video: nil, imageSubmission: UIImage(named:"totem-5"), score: 50),
        Contestant(avatar: UIImage(named:"avatar-6")!, video: nil, imageSubmission: UIImage(named:"totem-6"), score: 60),
        Contestant(avatar: UIImage(named:"avatar-7")!, video: nil, imageSubmission: UIImage(named:"totem-7"), score: 70),
        Contestant(avatar: UIImage(named:"avatar-8")!, video: nil, imageSubmission: UIImage(named:"totem-8"), score: 80),
        ] {
        didSet{
            totalScrollwidth = contestants.count * 47
            setAvatar()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(contest)
        
        thumbnail.image = contest.thumbnail
        votes.text = "\(contest.votes)"
        contestTitle.text = contest.title
        artist.text = contest.artist
        
        self.scrollview.contentSize = CGSizeMake(CGFloat(totalScrollwidth), 60)
        
        imageDance.image = contestants[0].imageSubmission
        
        setAvatar()
    }
    
    func setAvatar() {
        for subview: UIView in self.scrollview.subviews {
            subview.removeFromSuperview()
        }
        for i in 1...contestants.count {
            let integerToCG = CGFloat(i)
            
            let view: UIView = UIView(frame: CGRectMake((integerToCG-1)*47, 0, 47, 60))
            let imageView = UIImageView(frame: CGRectMake(4, 4, 39, 39))
            imageView.contentMode = .ScaleAspectFit
            imageView.image = contestants[i-1].avatar
            
            //Make the avatar look round
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.layer.masksToBounds = true
            
            view.addSubview(imageView)
            
            let button:UIButton = UIButton(frame: CGRectMake(0, 0, 47, 60))
            button.setTitle("", forState: .Normal)
            button.addTarget(self, action: #selector(ContestDetailsViewController.avatarButtonPressed(_:)), forControlEvents: .TouchUpInside)
            button.tag = 100 + i
            view.addSubview(button)
            
            let label:UILabel = UILabel(frame: CGRectMake(0, 45, 47, 14))
            label.font = UIFont(name: "AvenirNext-Regular", size: 10)
            label.textColor = UIColor.greenColor()
            label.textAlignment = .Center
            label.text = "^\(contestants[i-1].score)"
            view.addSubview(label)
            
            self.scrollview.addSubview(view)
            
        }
    }
    
    func avatarButtonPressed(button:UIButton) {
        let index = button.tag - 100 - 1
        self.selectedContestant = contestants[index]
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
    
    @IBAction func unWindToContestDetails(segue:UIStoryboardSegue) {
        if let _ = segue.sourceViewController as? JoinViewController {
            print("segued Back - JoinViewController")
//            appDelegate.unwindFlag = true
        }
    }
    

}
