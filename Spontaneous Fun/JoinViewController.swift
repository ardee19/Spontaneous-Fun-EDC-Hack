//
//  JoinViewController.swift
//  Spontaneous Fun
//
//  Created by i am awesome on 6/11/16.
//  Copyright © 2016 Super Awesome. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var contestTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    var contest:Contest = Contest()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        thumbnail.image = contest.thumbnail
        
        //Make the avatar look round
        thumbnail.layer.cornerRadius = thumbnail.frame.width / 2
        thumbnail.layer.masksToBounds = true
        
        votes.text = "\(contest.votes)"
        contestTitle.text = contest.title
        artist.text = contest.artist

        // Do any additional setup after loading the view.
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        presentViewController(picker, animated: true, completion: nil)
    }

    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBAction func cameraButtonTapped(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        presentViewController(picker, animated: true, completion: nil)
    }
    
    var imageTaken = false
    
    var contestant = Contestant(avatar: UIImage(named: "pierre")!, video: nil, imageSubmission: nil, score: 0)
    
    @IBAction func submitButtonTapped(sender: UIBarButtonItem) {
        if imageTaken {
            contestant = Contestant(avatar: UIImage(named: "pierre")!, video: nil, imageSubmission: imagePicked.image, score: 0)
            
            self.performSegueWithIdentifier(Segue.unWindToContestDetails, sender: nil )
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segue.unWindToContestDetails {
            let destination = segue.destinationViewController as! ContestDetailsViewController
            destination.contestants.insert(contestant, atIndex: 0)
//            destination.selectedContestant = contestant
            destination.selectContestant(contestant, index: 0)
        }
    }
}

extension JoinViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] {
            imagePicked.image = image as? UIImage
            imageTaken = true
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
