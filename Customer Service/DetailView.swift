//
//  DetailView.swift
//  Customer Service
//
//  Created by Stephen Casella on 4/19/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var isUpdating = true

var nameString = ""

class DetailView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var mainText: UILabel!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var numberText: UITextField!
    @IBOutlet var springView: SpringView!
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var hoursText: UITextField!
    
    
    
    @IBAction func callClick(sender: AnyObject) {
        if numberText.text!.length == 10 {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel:\(numberText.text!)")!)
        if askForReview == false {
            performSegueWithIdentifier("mainSegue", sender: self) } else {
            performSegueWithIdentifier("toReviewPageDetail", sender: self) }
        }}

    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        if isNew == false {
        
            nameCust.removeAtIndex(nameSet)
            numberCust.removeAtIndex(nameSet)
            hoursCust.removeAtIndex(nameSet)
            nameCust.insert(nameText.text!, atIndex: nameSet)
            numberCust.insert(numberText.text!, atIndex: nameSet)
            hoursCust.insert(hoursText.text!, atIndex: nameSet)
            
            NSUserDefaults.standardUserDefaults().setObject(nameCust, forKey: "nameCust")
            NSUserDefaults.standardUserDefaults().setObject(numberCust, forKey: "numberCust")
            NSUserDefaults.standardUserDefaults().setObject(hoursCust, forKey: "hoursCust")
            NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
            
        } else if favorites.indexOf(nameText.text!) != nil {
                
                print("Company name already favorited")
                
            } else {
            
            favorites.append(nameText.text!)
            nameCust.append(nameText.text!)
            numberCust.append(numberText.text!)
            hoursCust.append(hoursText.text!)
            
            NSUserDefaults.standardUserDefaults().setObject(nameCust, forKey: "nameCust")
            NSUserDefaults.standardUserDefaults().setObject(numberCust, forKey: "numberCust")
            NSUserDefaults.standardUserDefaults().setObject(hoursCust, forKey: "hoursCust")
            NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
                
            }
    
        performSegueWithIdentifier("mainSegue", sender: self)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        if isNew == false {
            
            mainText.hidden = false
            nameText.hidden = true
            
            mainText.text = favorites[nameSet]
            nameText.text = favorites[nameSet]
            numberText.text = numberCust[nameSet]
            hoursText.text = hoursCust[nameSet]
            
        } else if isNew == true {
            
            mainText.hidden = true
            nameText.hidden = false
            
        }

    }
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()

    }
    
    
    
    override func viewDidDisappear(animated: Bool) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        mainText.text = nameText.text
    }

    
    

    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField == numberText {
            if numberText.text!.characters.count == 10 || numberText.text!.characters.count == 0 {
                return true } else {
                numberText.text = ""
                numberText.placeholder = "Number format 1112223333"
                return true}
            
        }
        
        return true
    
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainSegue" {
       springView.animation = "fall"
        springView.duration = 1.5
        springView.animate()
        }
    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
  
}