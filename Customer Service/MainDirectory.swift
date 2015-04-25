//
//  MainDirectory.swift
//  Customer Service
//
//  Created by Stephen Casella on 4/11/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit



class MainDirectory: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    testone.favorites.removeAll(keepCapacity: false)
    for lookup in testone.favoriteNum {
    testone.favorites.append(name[lookup])
 
    }
    }
    func tableView(mainTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testone.favoriteNum.count
    }
    func tableView(mainTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       var cell : UITableViewCell! = mainTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        cell.textLabel!.text = testone.favorites[indexPath.row]

        return cell }
     func tableView(mainTable: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
         nameSet = testone.favoriteNum[indexPath.row]

    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(number[indexPath.row]))")!)
    }
}



