//
//  ViewController.swift
//  meme4ever
//
//  Created by Aysin Kuran on 11/25/15.
//  Copyright © 2015 Aysin Kuran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {

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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Subscribe to keyboard notifications 
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardwilhideNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set Text values
        topText.text = "TOP"
        topText.textAlignment = .Center
        topText.defaultTextAttributes = memeInputText
        self.topText.delegate = self
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = .Center
        bottomText.defaultTextAttributes = memeInputText
        self.bottomText.delegate = self
        
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
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        self.unsubscribeFromKeyboardwillhideNotifications()

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
    
    //all functions necessary to input the Text Fields
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
    //all functions necessary to move the view up & down for the Bottom Text Field
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomText.editing {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
        else {
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomText.editing {
            self.view.frame.origin.y += setKeyboardHeight(notification)
        }
        else {
        }
    }

    func subscribeToKeyboardwilhideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func setKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
     }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self,name: UIKeyboardWillShowNotification,object: nil)
    }
    
    func unsubscribeFromKeyboardwillhideNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
}

