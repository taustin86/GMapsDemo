//
//  MapStoryMediaNavigationController.swift
//  GMapsDemo
//
//  Created by Tamara Austin on 8/21/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class MapStoryMediaNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
