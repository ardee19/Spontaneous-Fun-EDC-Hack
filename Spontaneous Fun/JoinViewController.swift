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
        votes.text = "\(contest.votes)"
        contestTitle.text = contest.title
        artist.text = contest.artist

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var imagePicked: UIImageView!
    @IBAction func cameraButtonTapped(sender: UIButton) {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = false
//        picker.sourceType = .PhotoLibrary
//        picker.modalPresentationStyle = .FullScreen
//        presentViewController(picker, animated: true, completion: nil)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        presentViewController(picker, animated: true, completion: nil)
    }
}

extension JoinViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] {
            imagePicked.image = image as? UIImage
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
