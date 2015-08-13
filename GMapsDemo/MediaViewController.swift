//
//  MediaViewController.swift
//  GMapsDemo
//
//  Created by Tamara Austin on 8/7/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var media: UIImageView!
    
    var mediaPath = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Map", style:.Plain, target:self, action:Selector("backToMapTapped"))
        self.navigationItem.hidesBackButton = true
        
        self.media.image = UIImage(named: mediaPath)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func circleTapped(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func backToMapTapped() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
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
