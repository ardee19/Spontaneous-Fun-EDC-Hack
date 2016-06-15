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
    
    func respondToSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("Right")
                
                if currentContestantIndex > 0 {
                print("currentContestantIndex Before: \(currentContestantIndex)")
                currentContestantIndex -= 1
                    selectContestant(contestants[currentContestantIndex], index: currentContestantIndex)
                print("currentContestantIndex After: \(currentContestantIndex)")
                }
//                selectContestant(<#T##Contestant#>, index: <#T##Int#>)
            case UISwipeGestureRecognizerDirection.Left:
                print("Left")
                if currentContestantIndex < contestants.count - 1 {
                print("currentContestantIndex Before: \(currentContestantIndex)")
                currentContestantIndex += 1
                selectContestant(contestants[currentContestantIndex], index: currentContestantIndex)
                print("currentContestantIndex After: \(currentContestantIndex)")
                }
            case UISwipeGestureRecognizerDirection.Up:
                print("Up")
            case UISwipeGestureRecognizerDirection.Down:
                print("Down")
            default:
                break
            }
        }
    }
    
    var selectedContestant = Contestant() {
        didSet {
            if let image = selectedContestant.imageSubmission {
                imageDance.image = image
                if selectedContestant.voted {
                    voteButton.setImage(upVotedImage, forState: .Normal)
                } else {
                    voteButton.setImage(noVoteImage, forState: .Normal)
                }
                
            }
        }
    }
    
    var currentContestantIndex = 0
    
    @IBOutlet weak var voteButton: UIButton!
    
    func selectContestant(contestant:Contestant, index:Int) {
        self.selectedContestant = contestant
        self.currentContestantIndex = index
        setAvatar(currentContestantIndex)
        print("currentContestantIndex: \(currentContestantIndex)")
    }

    var totalScrollwidth = 380 {
        didSet {
            self.scrollview.contentSize = CGSizeMake(CGFloat(totalScrollwidth), 60)
        }
    }
    
    var votedFlag = false
    

    
    
    internal var contestants = [
        Contestant(avatar: UIImage(named:"avatar-1")!, video: nil, imageSubmission: UIImage(named:"imageDanceRaw"), score: 10),
        Contestant(avatar: UIImage(named:"avatar-2")!, video: nil, imageSubmission: UIImage(named:"imageGroupRaw"), score: 20),
        Contestant(avatar: UIImage(named:"avatar-3")!, video: nil, imageSubmission: UIImage(named:"totem-3"), score: 30),
        Contestant(avatar: UIImage(named:"avatar-4")!, video: nil, imageSubmission: UIImage(named:"totem-4"), score: 40),
        Contestant(avatar: UIImage(named:"avatar-5")!, video: nil, imageSubmission: UIImage(named:"totem-5"), score: 50),
        Contestant(avatar: UIImage(named:"avatar-6")!, video: nil, imageSubmission: UIImage(named:"totem-6"), score: 60),
        Contestant(avatar: UIImage(named:"avatar-7")!, video: nil, imageSubmission: UIImage(named:"totem-7"), score: 70),
        Contestant(avatar: UIImage(named:"avatar-8")!, video: nil, imageSubmission: UIImage(named:"totem-8"), score: 80),
        ] {
        didSet{
            totalScrollwidth = contestants.count * 47
            setAvatar(currentContestantIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(contest)
        
        thumbnail.image = contest.thumbnail
        
        //Make the avatar look round
        thumbnail.layer.cornerRadius = thumbnail.frame.width / 2
        thumbnail.layer.masksToBounds = true
        
        votes.text = "\(contest.votes)"
        contestTitle.text = contest.title
        artist.text = contest.artist
        
        self.scrollview.contentSize = CGSizeMake(CGFloat(totalScrollwidth), 60)
        
        imageDance.image = contestants[0].imageSubmission
        
        setAvatar(currentContestantIndex)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ContestDetailsViewController.respondToSwipe(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ContestDetailsViewController.respondToSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(swipeLeft)
    }
    
    func setAvatar(activeAvatar:Int) {
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
            
            if activeAvatar == (i - 1) {
                print("activeAvatar: \(activeAvatar) - currentContestantIndex: \(currentContestantIndex) - i: \(i), (i - 1): \(i - 1)")
                imageView.layer.borderColor = UIColor.greenColor().CGColor
                imageView.layer.borderWidth = 2
            }
            
            view.addSubview(imageView)
            
            let button:UIButton = UIButton(frame: CGRectMake(0, 0, 47, 60))
            button.setTitle("", forState: .Normal)
            button.addTarget(self, action: #selector(ContestDetailsViewController.avatarButtonPressed(_:)), forControlEvents: .TouchUpInside)
            button.tag = 100 + i
            view.addSubview(button)
            
            let label:UILabel = UILabel(frame: CGRectMake(0, 45, 47, 14))
            label.font = UIFont(name: "AvenirNext-Regular", size: 10)
            label.textColor = UIColor(red: 239/255, green: 8/255, blue: 255/255, alpha: 1)
            label.textAlignment = .Center
            label.text = "^\(contestants[i-1].score)"
            view.addSubview(label)
            self.scrollview.addSubview(view)
            
        }
    }
    
    func avatarButtonPressed(button:UIButton) {
        let index = button.tag - 100 - 1
        
        selectContestant(contestants[index], index: index)
        
//        self.selectedContestant = contestants[index]
    }
    
    var upVotedImage = UIImage(named: "vote-active")
    var noVoteImage = UIImage(named: "vote-inactive")
    
    @IBAction func upVote(sender: UIButton) {
        if !contestants[currentContestantIndex].voted {
            print("upVoted")
//            selectedContestant.score += 1
//            print(selectedContestant.score)
            contestants[currentContestantIndex].score += 1
            contestants[currentContestantIndex].voted = true
            sender.setImage(upVotedImage, forState: .Normal)
            setAvatar(currentContestantIndex)
            
//            votedFlag = true
        } else {
            contestants[currentContestantIndex].score -= 1
            contestants[currentContestantIndex].voted = false
            sender.setImage(noVoteImage, forState: .Normal)
            setAvatar(currentContestantIndex)
            print("You already voted")
        }
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
