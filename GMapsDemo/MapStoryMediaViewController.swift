//
//  MapStoryMediaViewController.swift
//  GMapsDemo
//
//  Created by Tamara Austin on 8/19/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import MediaPlayer

class MapStoryMediaViewController: UIViewController {
    static let image_type = "IMAGE"
    static let video_type = "VIDEO"
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var button: UIButton!
    
    var mediaUri: String!
    var mediaType: String!
    var backgroundColor: UIColor!
    var moviePlayer : MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Map", style:.Plain, target:self, action:Selector("backToMapTapped"))
        self.navigationItem.hidesBackButton = true
        
        view.backgroundColor = backgroundColor
        
        if mediaType == MapStoryMediaViewController.video_type {
            let path = NSBundle.mainBundle().pathForResource(mediaUri, ofType:"mp4")
            let url = NSURL.fileURLWithPath(path!)
            self.moviePlayer = MPMoviePlayerController(contentURL: url)
            if let player = self.moviePlayer {
                player.view.frame = CGRect(x: 0, y: 0, width: subView.frame.size.width, height: subView.frame.size.height)
                player.view.sizeToFit()
                player.scalingMode = MPMovieScalingMode.Fill
                player.fullscreen = true
                player.controlStyle = MPMovieControlStyle.None
                player.movieSourceType = MPMovieSourceType.File
                player.repeatMode = MPMovieRepeatMode.One
                player.play()
                subView.addSubview(player.view)
            }
        } else {
            let image = UIImage(named: mediaUri)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: subView.frame.size.width, height: subView.frame.size.height)
            subView.addSubview(imageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
