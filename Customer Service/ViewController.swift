//
//  ViewController.swift
//  Customer Service
//
//  Created by Stephen Casella on 4/11/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var nameSet: Int = 0

var customNum = 0

var favorites = [String]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var listTable: UITableView!
  
    @IBAction func customButton(sender: AnyObject) {
        
        isUpdating = false
        performSegueWithIdentifier("customSegue", sender: self)
        
    }
    var resultSearchController = UISearchController()

    var filteredNames = [String]()
    
    @IBAction func tapGesture(sender: AnyObject) {
        mainTable.hidden = false
        resultSearchController.searchBar.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().objectForKey("name") != nil{
        name = NSUserDefaults.standardUserDefaults().objectForKey("name")! as! [String] }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("number") != nil{
            number = NSUserDefaults.standardUserDefaults().objectForKey("number")! as! [String]}
       
        if NSUserDefaults.standardUserDefaults().objectForKey("hours") != nil{
            hours = NSUserDefaults.standardUserDefaults().objectForKey("hours")! as! [String]}
        
        if name.count < 2 {
            
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
            
            NSUserDefaults.standardUserDefaults().setObject(name, forKey: "name")}
        
       if number.count < 2  {

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
            
        NSUserDefaults.standardUserDefaults().setObject(number, forKey: "number") }

        
        if hours.count < 2  {

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
            
            NSUserDefaults.standardUserDefaults().setObject(hours, forKey: "hours")}

    
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self
            self.listTable!.tableHeaderView = controller.searchBar
            
            return controller
        })()
    
    }
    
    override func viewDidLoad(){
           super.viewDidLoad()
    
        resultSearchController.searchBar.delegate = self
        
    }
    
    override func viewDidDisappear(animated: Bool){
        NSUserDefaults.standardUserDefaults().setObject(favorites, forKey: "favorites")
        
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
    
    func presentSearchController(searchController: UISearchController){
        
         resultSearchController.searchBar.showsCancelButton = false
        mainTable.hidden = true

}

    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredNames.removeAll(keepCapacity: false)
        
        resultSearchController.searchBar.showsCancelButton = false
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
         let array = (name as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredNames = array as! [String]
        self.listTable!.reloadData()
          mainTable.hidden = true
    }
    
     func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        if tableView == mainTable {
          
            nameString = "\(favorites[indexPath.row])"
            
            performSegueWithIdentifier("detailSegue", sender: self)
        
        } else {
            
            nameString = "\(filteredNames[indexPath.row])"
            
            performSegueWithIdentifier("detailSegue", sender: self)
    }
    
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            nameSet = indexPath.row
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(number[nameSet]))")!)
    }
        
        
        
    }
}