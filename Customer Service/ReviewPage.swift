//
//  ReviewPage.swift
//  Hotline YP
//
//  Created by Stephen Casella on 7/12/15.
//  Copyright (c) 2015 Stephen Casella. All rights reserved.
//

import UIKit

class ReviewPage: UIViewController {
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "noThanks": askForReview = false
        NSUserDefaults.standardUserDefaults().setObject(askForReview, forKey: "askForReview")
        case "Later": print("Do Nothing")
        case "Sure": if let checkURL = NSURL(string: "https://itunes.apple.com/us/app/hotline-yellow-pages-customer/id1006278912?ls=1&mt=8") {
            if UIApplication.sharedApplication().openURL(checkURL) {
            }}
        askForReview = false
        NSUserDefaults.standardUserDefaults().setObject(askForReview, forKey: "askForReview")
        default: print("Do Nothing")
        }}



override func viewDidDisappear(animated: Bool) {
    self.dismissViewControllerAnimated(true, completion: nil)
}

}