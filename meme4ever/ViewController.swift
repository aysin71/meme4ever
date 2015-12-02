//
//  ViewController.swift
//  meme4ever
//
//  Created by Aysin Kuran on 11/25/15.
//  Copyright © 2015 Aysin Kuran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let imagePick = UIImagePickerController()
    
    @IBOutlet weak var cameraAvailable: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePick.delegate = self
        
        if UIImagePickerController.isCameraDeviceAvailable( UIImagePickerControllerCameraDevice.Front) {
            cameraAvailable.enabled = true
        }
        else {
            cameraAvailable.enabled = false
        }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func imagePickController(sender: AnyObject) {
        imagePick.allowsEditing = false
        imagePick.sourceType = .PhotoLibrary
        presentViewController(imagePick, animated: false, completion: nil)
    }
    
    @IBAction func cameraController (sender: AnyObject) {
        
        if UIImagePickerController.isCameraDeviceAvailable(   UIImagePickerControllerCameraDevice.Front) {
            imagePick.delegate = self
            imagePick.allowsEditing = false
            imagePick.sourceType = .Camera
            presentViewController(imagePick, animated: true, completion: nil)
        } else {
            print("no front camera available")
        }
    }
    
    func imagePickerController(imagePick: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            imageView.image = ((info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as! UIImage)
    imagePick.dismissViewControllerAnimated(true, completion: nil)

    }
}

