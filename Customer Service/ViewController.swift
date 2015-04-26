//
//  ViewController.swift
//  Customer Service
//
//  Created by Stephen Casella on 4/11/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var nameSet: Int = 0

var newSave = false

var fromList = true

var customNum = 0

var favorites = [String]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var listTable: UITableView!
  
    @IBAction func customButton(sender: AnyObject) {
        newSave = true
        isUpdating = false
        fromList = false
        performSegueWithIdentifier("customSegue", sender: self)
        
    }
    var resultSearchController = UISearchController()

    var filteredNames = [String]()
    
    @IBAction func tapGesture(sender: AnyObject) {
        mainTable.hidden = false
        resultSearchController.searchBar.resignFirstResponder()
    }

    override func viewWillAppear(animated: Bool) {
        
        if NSUserDefaults.standardUserDefaults().objectForKey("favorites") != nil {
            
        favorites = NSUserDefaults.standardUserDefaults().objectForKey("favorites") as! [String]
        nameCust = NSUserDefaults.standardUserDefaults().objectForKey("nameCust") as! [String]
        numberCust = NSUserDefaults.standardUserDefaults().objectForKey("numberCust") as! [String]
        hoursCust = NSUserDefaults.standardUserDefaults().objectForKey("hoursCust") as! [String] }
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                
                if error == nil {
                    
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    
                    var urlContentArray = urlContent.componentsSeparatedByString(",")
                    
                    for index in urlContentArray {
                        
                        name.append(index as! String)
                        
                    }
                    
                } else {
                    
                    urlError=true
                    
                    println("error")}
            })
            
            task.resume()
            
           name + nameCust

            let task2 = NSURLSession.sharedSession().dataTaskWithURL(url2!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                
                if error == nil {
                    
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    
                    var urlContentArray = urlContent.componentsSeparatedByString(",")
                    
                    for index in urlContentArray {
                        number.append(index as! String)
                        
                    }
                    
                } else {
                    
                    urlError=true
                    println("error")}
            })
            
            task2.resume()
            
            number + numberCust

            let task3 = NSURLSession.sharedSession().dataTaskWithURL(url3!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                
                if error == nil {
                    
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    
                    var urlContentArray = urlContent.componentsSeparatedByString(",")
                    
                    for index in urlContentArray {
                     hours.append(index as! String)
                        
                    }
                    
                } else {
                    
                    urlError=true
                    
                    println("error")}
            })
            
            task3.resume()
            
            hours + hoursCust

    
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self
            controller.searchBar.showsCancelButton = false
            self.listTable!.tableHeaderView = controller.searchBar
            
            return controller
            
        })()
    
         self.listTable.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func viewDidLoad(){
           super.viewDidLoad()
       
        self.resultSearchController.searchBar.delegate = self
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            return self.filteredNames.count
        } else if tableView == listTable {
         return 0
        } else {
              return favorites.count        }
        }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell! = listTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
        }
        if (self.resultSearchController.active) {
            cell.textLabel?.text = filteredNames[indexPath.row] as String
            
            cell.accessoryType = .DetailButton
            
            return cell
            
        } else if tableView == listTable {
            
            cell.textLabel!.text = ""
            
                cell.accessoryType = .DetailButton
            
            return cell
            
        } else {
            var cell2 : UITableViewCell! = mainTable.dequeueReusableCellWithIdentifier("Cell2") as! UITableViewCell
           
            cell2.textLabel!.text = favorites[indexPath.row]
            
                cell2.accessoryType = .DetailButton
            
            return cell2}
    }

    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredNames.removeAll(keepCapacity: false)
        
        resultSearchController.searchBar.showsCancelButton = false
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
         let array = (name as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredNames = array as! [String]
        if filteredNames.count < 1 {
            mainTable.hidden = false
        } else {
            mainTable.hidden = true
        }
        self.listTable!.reloadData()
      
    }
    
    func presentSearchController(searchController: UISearchController) {
        resultSearchController.searchBar.showsCancelButton = false
        mainTable.hidden = true

    }

    
     func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        if tableView == mainTable {
            
            newSave = false
            
            fromList = false
            
            isUpdating = true
            
            nameString = "\(favorites[indexPath.row])"
            
            nameSet = indexPath.row
            
            performSegueWithIdentifier("detailSegue", sender: self)
        
        } else {
            
            newSave = false
            
            isUpdating = true 
            
            fromList = true
            
            nameString = "\(name[indexPath.row])"
            
            nameSet = indexPath.row
            
            performSegueWithIdentifier("detailSegue", sender: self)
        }}
    
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            nameSet = indexPath.row
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(number[nameSet]))")!)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            favorites.removeAtIndex(indexPath.row)
            
            nameCust.removeAtIndex(indexPath.row)
            
            numberCust.removeAtIndex(indexPath.row)
            
            hoursCust.removeAtIndex(indexPath.row)
            
            NSUserDefaults.standardUserDefaults().setObject(nameCust, forKey: "nameCust")
            NSUserDefaults.standardUserDefaults().setObject(numberCust, forKey: "numberCust")
            NSUserDefaults.standardUserDefaults().setObject(hoursCust, forKey: "hoursCust")
            NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
            
            mainTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
}
    }

