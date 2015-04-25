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
    
    @IBOutlet var numberText: UITextField!
    
    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var updateButton: UIButton!
    
    @IBOutlet var hoursText: UITextField!
    
    @IBAction func saveButton(sender: AnyObject) {
        
        if isUpdating == true {
                
            name.removeAtIndex(nameSet)
            number.removeAtIndex(nameSet)
            hours.removeAtIndex(nameSet)
            
        name.insert(nameText.text, atIndex: nameSet)
        
        number.insert(numberText.text, atIndex: nameSet)
        
        hours.insert(hoursText.text, atIndex: nameSet)
            
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: "name")
        NSUserDefaults.standardUserDefaults().setObject(number, forKey: "number")
        NSUserDefaults.standardUserDefaults().setObject(hours, forKey: "hours")
  
            
        } else {
            
            name.append(nameText.text)
            
            number.append(numberText.text)
            
            hours.append(hoursText.text)
            
            customNum = customNum + 1
            
            if NSUserDefaults.standardUserDefaults().objectForKey("customNum") == nil {
                
                customNum = customNum + 1} else {
                
                customNum = NSUserDefaults.standardUserDefaults().objectForKey("customNum")! as! Int
                
                customNum = customNum + 1 }
                
                NSUserDefaults.standardUserDefaults().setObject(customNum, forKey: "customNum")
                NSUserDefaults.standardUserDefaults().setObject(name, forKey: "name")
                NSUserDefaults.standardUserDefaults().setObject(number, forKey: "number")
                NSUserDefaults.standardUserDefaults().setObject(hours, forKey: "hours")
        }
        
    }
    
    @IBAction func favoriteButton(sender: AnyObject) {
        
        favorites.append(nameString)
        
        if NSUserDefaults.standardUserDefaults().objectForKey("customNum") == nil {
            
            customNum = customNum + 1} else {
            
            customNum = NSUserDefaults.standardUserDefaults().objectForKey("customNum")! as! Int
            
            customNum = customNum + 1 }
            
        performSegueWithIdentifier("mainSegue", sender: self)
    
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if isUpdating == false {
            
            favoriteButton.enabled = false
            
        } else {
            
            nameSet = find(name, nameString) as Int!
            
            favoriteButton.enabled = true
            
            mainText.text = name[nameSet]
            
            nameText.text = name[nameSet]
            
            numberText.text = number[nameSet]
            
            hoursText.text = hours[nameSet]
        
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        mainText.text = nameText.text
    }

    
    
}
