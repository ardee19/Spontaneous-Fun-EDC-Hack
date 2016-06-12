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

    var totalScrollwidth = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(contest)
        
        thumbnail.image = contest.thumbnail
        votes.text = "\(contest.votes)"
        contestTitle.text = contest.title
        artist.text = contest.artist
        
        self.scrollview.contentSize = CGSizeMake(CGFloat(totalScrollwidth), 60)
        
        
        let view: UIView = UIView(frame: CGRectMake(0, 0, 47, 60))
//        view.backgroundColor = UIColor.greenColor()
        let imageView = UIImageView(frame: CGRectMake(4, 4, 39, 39))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "avatar-1")
        
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        
        view.addSubview(imageView)
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 45, 47, 14))
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        label.textColor = UIColor.greenColor()
        label.textAlignment = .Center
        label.text = "^412"
        view.addSubview(label)
    
        self.scrollview.addSubview(view)
        
//        for i in 1...10 {
//            let iCG = CGFloat(integerLiteral: i)
//            let view = UIView(frame: CGRectMake(60.0 * iCG,0,60,60))
//            if i % 2 == 0 {
//                view.backgroundColor = UIColor.purpleColor()
//            } else {
//                view.backgroundColor = UIColor.orangeColor()
//            }
//            self.scrollview.addSubview(view)
//        }
//        
//        let view2: UIView = UIView(frame: CGRectMake(60, 0, 60, 60))
//        view2.backgroundColor = UIColor.redColor()
//        self.scrollview.addSubview(view2)


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
