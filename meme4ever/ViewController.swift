//
//  ViewController.swift
//  meme4ever
//
//  Created by Aysin Kuran on 11/25/15.
//  Copyright © 2015 Aysin Kuran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Outlet definitions
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraAvailable: UIBarButtonItem!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    //definitions
    let imagePick = UIImagePickerController()

    let memeInputText = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : NSNumber(float: -4.0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set Text values
        //topText.text = "TOP"
        topText.textAlignment = .Center
        topText.defaultTextAttributes = memeInputText
        //bottomText.text = "BOTTOM"
        bottomText.textAlignment = .Center
        bottomText.defaultTextAttributes = memeInputText
        
        //set imagepicker and disable camera when not available
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
            imagePick.delegate = self
            imagePick.allowsEditing = false
            imagePick.sourceType = .Camera
            presentViewController(imagePick, animated: true, completion: nil)
    }
    
    func imagePickerController(imagePick: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            imageView.image = ((info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as! UIImage)
    imagePick.dismissViewControllerAnimated(true, completion: nil)

    }
}

