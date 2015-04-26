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
        
            nameCust.removeAtIndex(nameSet)
            
            nameCust.removeAtIndex(nameSet)
            
            nameCust.removeAtIndex(nameSet)
            
            nameCust.insert(nameText.text, atIndex: nameSet)
            
            numberCust.insert(numberText.text, atIndex: nameSet)
            
            hoursCust.insert(hoursText.text, atIndex: nameSet)
            
            NSUserDefaults.standardUserDefaults().setObject(nameCust, forKey: "nameCust")
            NSUserDefaults.standardUserDefaults().setObject(numberCust, forKey: "numberCust")
            NSUserDefaults.standardUserDefaults().setObject(hoursCust, forKey: "hoursCust")
            NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
            
        } else {
            
            if find(favorites, nameText.text) != nil {
                
                println("Company name already favorited")
                
            } else {
            
            favorites.append(nameText.text)
            
            nameCust.append(nameText.text)
            
            numberCust.append(numberText.text)
            
            hoursCust.append(hoursText.text)
            
            NSUserDefaults.standardUserDefaults().setObject(nameCust, forKey: "nameCust")
            NSUserDefaults.standardUserDefaults().setObject(numberCust, forKey: "numberCust")
            NSUserDefaults.standardUserDefaults().setObject(hoursCust, forKey: "hoursCust")
            NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
                
            }
            
        }
        
        performSegueWithIdentifier("mainSegue", sender: self)
        
    }
    
    @IBAction func favoriteButton(sender: AnyObject) {
        
        favorites.append(nameString)
        
        nameCust.append(nameText.text)
        
        numberCust.append(numberText.text)
        
        hoursCust.append(hoursText.text)
        
        NSUserDefaults.standardUserDefaults().setObject(nameCust, forKey: "nameCust")
        NSUserDefaults.standardUserDefaults().setObject(numberCust, forKey: "numberCust")
        NSUserDefaults.standardUserDefaults().setObject(hoursCust, forKey: "hoursCust")
        NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
    
        performSegueWithIdentifier("mainSegue", sender: self)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if fromList == true {
            
            favoriteButton.enabled = true
            
            mainText.text = name[nameSet]
            
            nameText.text = name[nameSet]
            
            numberText.text = number[nameSet]
            
            hoursText.text = hours[nameSet]
            
        } else if newSave == true {
            
            mainText.text = "New Entry"
            
        } else {
        
            mainText.text = favorites[nameSet]
            
            nameText.text = favorites[nameSet]
            
            numberText.text = numberCust[nameSet]
            
            hoursText.text = hoursCust[nameSet]
            
        }

    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if isUpdating == false {
            
            favoriteButton.enabled = false
            
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        mainText.text = nameText.text
    }

    
    
}
