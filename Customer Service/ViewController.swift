//
//  ViewController.swift
//  Customer Service
//
//  Created by Stephen Casella on 4/11/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var askForReview = true

var callingNow = false

var nameSet: Int = 0

var filteredCount = 0

var isNew = false

var customNum = 0

var favorites = [String]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UITextFieldDelegate{

    @IBOutlet var searchBox: SpringTextField!
    @IBOutlet var titleHeader: UIImageView!
    @IBOutlet var addmore: UILabel!
    @IBOutlet var searchImg: SpringButton!
    @IBOutlet var searchView: UIView!
    @IBOutlet var addButton: SpringButton!
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var listTable: UITableView!
    var resultSearchController = UISearchController()
    var filteredNames = [String]()
    
    
    
    @IBAction func editChange(sender: AnyObject) {
        
        filteredNames.removeAll(keepCapacity: false)

        
        let searchPredicate = NSPredicate(format: "SELF BEGINSWITH [c] %@", searchBox.text)
        let array = (name as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredNames = array as! [String]
        
        if filteredNames.count < 1 {
 
        } else {
            
            mainTable.hidden = true

        }
        
            smallSearch.hidden = false
            self.listTable!.reloadData()

        }
  
    
    
    @IBOutlet var smallSearch: SpringButton!
    
    
    
    @IBAction func searchButton(sender: AnyObject) {
        if mainTable.hidden == false {
        
            searchBox.text = ""
            listTable.reloadData()
            searchBox.animation = "morph"
            searchBox.delay = 0.15
            searchBox.force = 1.2
            searchBox.duration = 1.25
            searchBox.animate()
            //searchImg.animation = "flipX"
            searchImg.setImage(UIImage(named: "homeGreen.png"), forState: UIControlState.Normal)
            //searchImg.duration = 0.25
            //searchImg.animate()
            mainTable.hidden = true
            searchView.hidden = false
            
        } else {
            searchBox.resignFirstResponder()
            searchView.hidden = true
            smallSearch.hidden = true
            mainTable.hidden = false
            //searchImg.animation = "flipX"
            //searchImg.duration = 0.25
            //searchImg.animate()
            searchImg.setImage(UIImage(named: "newGreenB.png"), forState: UIControlState.Normal)
            mainTable.reloadData()
        
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        println("TEST")
    }
    
    //Fav Results Add Button
    func buttonClicked(sender:UIButton) {
        
        var buttonRow = sender.tag
        var lookup = find(name, filteredNames[buttonRow]) //locate company within directory
        
        favorites.append(filteredNames[buttonRow])
        nameCust.append(filteredNames[buttonRow])
        numberCust.append(number[lookup!])
        hoursCust.append(hours[lookup!])
        
        NSUserDefaults.standardUserDefaults().setObject(nameCust, forKey: "nameCust")
        NSUserDefaults.standardUserDefaults().setObject(numberCust, forKey: "numberCust")
        NSUserDefaults.standardUserDefaults().setObject(hoursCust, forKey: "hoursCust")
        NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
        
        listTable.reloadData()
        mainTable.reloadData()
        
    }
    
    
    
    @IBAction func callNow(sender: UIButton) {
        callingNow = true
        NSUserDefaults.standardUserDefaults().setObject(callingNow, forKey: "callingNow")
        var numLookup = sender.tag
        var rightNum = find(name, filteredNames[numLookup])
         UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(number[rightNum!])")!)
         performSegueWithIdentifier("toReviewPage", sender: self)
    }
   

    
      @IBAction func customButton(sender: AnyObject) {
       
        isNew = true
        searchImg.hidden = true
        addButton.hidden = true 
        performSegueWithIdentifier("customSegue", sender: self)
        
    }
    

    
    //Create directory arrays
    override func viewWillAppear(animated: Bool) {
        
        if NSUserDefaults.standardUserDefaults().objectForKey("favorites") != nil {
            
        favorites = NSUserDefaults.standardUserDefaults().objectForKey("favorites") as! [String]
        nameCust = NSUserDefaults.standardUserDefaults().objectForKey("nameCust") as! [String]
        numberCust = NSUserDefaults.standardUserDefaults().objectForKey("numberCust") as! [String]
        hoursCust = NSUserDefaults.standardUserDefaults().objectForKey("hoursCust") as! [String] }
        
        var namePath = NSBundle.mainBundle().pathForResource("name", ofType: "txt")
        var nameUrl = NSURL.fileURLWithPath(namePath!)
        var error: NSError?
        let nameContent = NSString(contentsOfFile: namePath!, encoding:NSUTF8StringEncoding, error: &error)
       
        if nameContent != nil {
           var nameReformat = nameContent!.componentsSeparatedByString("=")
            for index in nameReformat {
                  name.append(index as! String)
            }
                
            
        } else {
            println("error: \(error)")
        }
     
        var numbersPath = NSBundle.mainBundle().pathForResource("numbers", ofType: "txt")
        var numbersUrl = NSURL.fileURLWithPath(numbersPath!)
        let numbersContent = NSString(contentsOfFile: numbersPath!, encoding:NSUTF8StringEncoding, error: &error)
        if numbersContent != nil {
            var numbersReformat = numbersContent!.componentsSeparatedByString("=")
            for index in numbersReformat {
                number.append(index as! String)
            }
        
            
        } else {
            println("error: \(error)")
        }
        
        var hoursPath = NSBundle.mainBundle().pathForResource("hours", ofType: "txt")
        var hoursUrl = NSURL.fileURLWithPath(hoursPath!)
        let hoursContent = NSString(contentsOfFile: hoursPath!, encoding:NSUTF8StringEncoding, error: &error)
        if hoursContent != nil {
            var hoursReformat = hoursContent!.componentsSeparatedByString("=")
            for index in hoursReformat {
                hours.append(index as! String)
            }
            
            
        } else {
            println("error: \(error)")
        }
    }


    override func viewDidLoad(){
           super.viewDidLoad()
     }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//Table Setup
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBox.isFirstResponder() == true{
            return self.filteredNames.count
        } else if tableView == listTable {
         return 0
        } else {
              return favorites.count        }
        }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : CustomCell! = listTable.dequeueReusableCellWithIdentifier("Cell") as! CustomCell
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! CustomCell;
        }
        if searchBox.isFirstResponder() == true  {
            cell.listLabel.text = filteredNames[indexPath.row] as String
            cell.addButton.tag = indexPath.row
            cell.callButton.tag = indexPath.row
            cell.addButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.callButton.addTarget(self, action: "callNow:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.checkImg.hidden = true 
            cell.addButton.hidden = true
            cell.callButton.hidden = true
            cell.listLabel.textColor = UIColor.blackColor()

            return cell
            
        } else {
           
            if tableView == mainTable {
                
            var cell2 : MainCell! = mainTable.dequeueReusableCellWithIdentifier("Cell2") as! MainCell
            cell2.cellLabel.text = favorites[indexPath.row]
            
           
            if nameCust.count != 0 {
                
            var bgSet: Int = find(nameCust, cell2.cellLabel.text!)!
                
            }

            
            //cell2.accessoryType = .DetailButton
            
            return cell2
        }
            return cell
        }}
    
    

        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
             nameSet = indexPath.row
            
            if tableView == listTable {
            
            var currentCell = listTable.cellForRowAtIndexPath(indexPath) as! CustomCell
            
            if find(nameCust, currentCell.listLabel.text!) == nil{
                    currentCell.addButton.hidden = false } else {
                    currentCell.checkImg.hidden = false
                    }
                    currentCell.callButton.hidden = false
                    currentCell.listLabel.textColor = UIColor.blackColor() }
    
            else {
            
                    searchImg.hidden = true
                    addButton.hidden = true
                    isNew = false
                    performSegueWithIdentifier("customSegue", sender: self)

    
    
            }}
    

    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == listTable{
            
            if listTable.cellForRowAtIndexPath(indexPath) != nil {
           
                var currentCell = listTable.cellForRowAtIndexPath(indexPath) as! CustomCell
                currentCell.addButton.hidden = true
                currentCell.checkImg.hidden = true
                currentCell.callButton.hidden = true
                currentCell.listLabel.textColor = UIColor.blackColor()}}}

        
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == listTable {
            
            listTable.setEditing(false, animated: true)
            
        } else if tableView == mainTable && editingStyle == UITableViewCellEditingStyle.Delete  {
            
            favorites.removeAtIndex(indexPath.row)
            nameCust.removeAtIndex(indexPath.row)
            numberCust.removeAtIndex(indexPath.row)
            hoursCust.removeAtIndex(indexPath.row)
            
            NSUserDefaults.standardUserDefaults().setObject(nameCust, forKey: "nameCust")
            NSUserDefaults.standardUserDefaults().setObject(numberCust, forKey: "numberCust")
            NSUserDefaults.standardUserDefaults().setObject(hoursCust, forKey: "hoursCust")
            NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
            
            mainTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            mainTable.reloadData() }
        
    }
    
    
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
      
        searchView.hidden = true
        smallSearch.hidden = true
       // searchImg.animation = "flipX"
        //searchImg.duration = 0.25
        //searchImg.animate()
        searchImg.setImage(UIImage(named: "newGreenB.png"), forState: UIControlState.Normal)
    
        return true

    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    func textFieldDidEndEditing(textField: UITextField) {
          mainTable.hidden = false
        mainTable.reloadData()
    }
    
       }



