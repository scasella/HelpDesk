//
//  ViewController.swift
//  Customer Service
//
//  Created by Stephen Casella on 4/11/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

var nameSet: Int = 0

var filteredCount = 0

var isNew = false

var customNum = 0

var favorites = [String]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate{
    
    @IBOutlet var searchBox: UITextField!
 
    @IBOutlet var titleHeader: UIImageView!
    
    @IBAction func editChange(sender: AnyObject) {
        
        filteredNames.removeAll(keepCapacity: false)

        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchBox.text)
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
         searchImg.animation = "flipX"
            searchImg.setImage(UIImage(named: "HeartImg.png"), forState: UIControlState.Normal)
            searchImg.duration = 0.25
            searchImg.animate()
        mainTable.hidden = true
        searchView.hidden = false
            
        } else {
            searchBox.resignFirstResponder()
            searchView.hidden = true
            smallSearch.hidden = true
            mainTable.hidden = false
            
             searchImg.animation = "flipX"
            searchImg.duration = 0.25
            searchImg.animate()
            searchImg.setImage(UIImage(named: "SeachImg.png"), forState: UIControlState.Normal)
             mainTable.reloadData()
        
        }
        
    }
    
    @IBOutlet var searchImg: SpringButton!
    
    @IBOutlet var searchView: UIView!
    
    @IBOutlet var callNoExpand: SpringImageView!
    @IBOutlet var addButton: SpringButton!
    
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
        
        
       /* var numLookup = numberCust[sender.tag]
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(numLookup))")!)
        mainTable.reloadData()*/


    
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var listTable: UITableView!
    
    @IBAction func customButton(sender: AnyObject) {
       
        isNew = true
        callNoExpand.hidden = true
        searchImg.hidden = true
        addButton.hidden = true 
        performSegueWithIdentifier("customSegue", sender: self)
        
    }
    
    var resultSearchController = UISearchController()

    var filteredNames = [String]()

    
    //Download and load saved stuff
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

    
        /* self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.frame = frame
            controller.searchBar.backgroundImage = UIImage(named: "Background.png")
            controller.searchBar.delegate = self
            self.resultSearchController.searchBar.delegate = self
            self.listTable!.tableHeaderView = controller.searchBar
            
            return controller  })*/
            
       ()
     
        
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
            cell.addButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            
            cell.listCellBG.image = UIImage(named: "")
            cell.addButton.hidden = true
            cell.callButton.hidden = true
            cell.listLabel.textColor = UIColor.blackColor()

            return cell
            
        } else {
            var cell2 : MainCell! = mainTable.dequeueReusableCellWithIdentifier("Cell2") as! MainCell
            
            
            cell2.cellLabel.text = favorites[indexPath.row]
            
           
            if nameCust.count != 0 {
                
            var bgSet: Int = find(nameCust, cell2.cellLabel.text!)!
    
            /*switch bgSet {
            case 0 : cell2.cellBG.image = UIImage(named: "orangeItem.png")
            case 1 : cell2.cellBG.image = UIImage(named: "greenItem.png")
            case 2 : cell2.cellBG.image = UIImage(named: "pinkItem.png")
            case 3 : cell2.cellBG.image = UIImage(named: "blueItem.png")
            case 4 :  cell2.cellBG.image = UIImage(named: "purpleItem.png"); prevBG = "orangeItem.png"
            default : switch prevBG {
            case "orangeItem.png" : cell2.cellBG.image = UIImage(named: "orangeItem.png"); prevBG = "greenItem.png"
            case "greenItem.png" : cell2.cellBG.image = UIImage(named: "greenItem.png"); prevBG = "pinkItem.png"
            case "pinkItem.png" : cell2.cellBG.image = UIImage(named: "pinkItem.png"); prevBG = "blueItem.png"
            case "blueItem.png" : cell2.cellBG.image = UIImage(named: "blueItem.png"); prevBG = "purpleItem.png"
            default : cell2.cellBG.image = UIImage(named: "purpleItem.png"); prevBG = "orangeItem.png"
                }
                }*/
                
            }

            
            //cell2.accessoryType = .DetailButton
            
            return cell2}
    }
    


    //Search controller
   /* func updateSearchResultsForSearchController(searchController: UISearchController) {
        
  
        filteredNames.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
         let array = (name as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredNames = array as! [String]
        if filteredNames.count < 1 {
        
    
            
        } else {

            mainTable.hidden = true
    

        }
            smallSearch.hidden = false
        self.listTable!.reloadData()
      
    }
    
    func presentSearchController(searchController: UISearchController) {
        
        mainTable.hidden = true


    }

  

   //mainTable Acessory Button
     /* func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
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
            
            nameString = "\(name[find(name, filteredNames[indexPath.row])!])"
            
            nameSet = find(name, nameString)!
            
            performSegueWithIdentifier("detailSegue", sender: self)
        }} */
    
    //Call number and change text color of row
    */


        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
             nameSet = indexPath.row
            
            if tableView == listTable {
            var currentCell = listTable.cellForRowAtIndexPath(indexPath) as! CustomCell
            currentCell.listCellBG.image = UIImage(named: "CellHL.png")
            currentCell.addButton.hidden = false
            currentCell.callButton.hidden = false
                currentCell.listLabel.textColor = UIColor.whiteColor() }
    
    else {
    callNoExpand.hidden = true
    searchImg.hidden = true
    addButton.hidden = true
    isNew = false
    performSegueWithIdentifier("customSegue", sender: self)

    
    
            }}
    
           /* else {
        
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(number[nameSet]))")!)   USE FOR CALL BUTTON
                
            } */
        

    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == listTable{
            
            if listTable.cellForRowAtIndexPath(indexPath) != nil {
            var currentCell = listTable.cellForRowAtIndexPath(indexPath) as! CustomCell
            currentCell.listCellBG.image = UIImage(named: "")
            currentCell.addButton.hidden = true
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
    
       }
    


