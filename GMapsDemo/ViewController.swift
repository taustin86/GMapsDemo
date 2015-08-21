//
//  ViewController.swift
//  GMapsDemo
//
//  Created by Gabriel Theodoropoulos on 29/3/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var viewMap: GMSMapView!
    @IBOutlet weak var bbFindAddress: UIBarButtonItem!
    @IBOutlet weak var lblInfo: UILabel!
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    let redIcon = UIImage(named: "tap-red")
    let redIconSmall = UIImage(named: "tap-red-small")
    let yellowIcon = UIImage(named: "tap-yellow")
    let yellowIconSmall = UIImage(named: "tap-yellow-small")
    let greenIcon = UIImage(named: "tap-green")
    let greenIconSmall = UIImage(named: "tap-green-small")
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var mapStoryService = MapStoryService(context: self.managedObjectContext!)

        viewMap.delegate = self
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(48.857165, longitude: 2.354613, zoom: 8.0)
        viewMap.camera = camera
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        
        var markers = [GMSMarker]()
        let mapStoryManifest = mapStoryService.getMapStories()
        for mapStory in mapStoryManifest.mapStories {
            if mapStory.count > mapStoryManifest.topTierUpvoteMin {
                if mapStory.count > mapStoryManifest.averageUpvoteCount {
                    markers.append(generateMarker(redIcon!, count: mapStory.count.description, location: mapStory.coordinates))
                } else {
                    markers.append(generateMarker(redIconSmall!, count: mapStory.count.description, location: mapStory.coordinates))
                }
            } else if mapStory.count > mapStoryManifest.bottomTierUpvoteMax {
                if mapStory.count > mapStoryManifest.averageUpvoteCount {
                    markers.append(generateMarker(yellowIcon!, count: mapStory.count.description, location: mapStory.coordinates))
                } else {
                    markers.append(generateMarker(yellowIconSmall!, count: mapStory.count.description, location: mapStory.coordinates))
                }
            } else {
                if mapStory.count > mapStoryManifest.averageUpvoteCount {
                    markers.append(generateMarker(greenIcon!, count: mapStory.count.description, location: mapStory.coordinates))
                } else {
                    markers.append(generateMarker(greenIconSmall!, count: mapStory.count.description, location: mapStory.coordinates))
                }
            }
        }
        
        for marker in markers { marker.map = viewMap }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 14.0)
            viewMap.settings.myLocationButton = true
            
            didFindMyLocation = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MapStorySegue") {
            var navController = segue.destinationViewController as! UINavigationController
            navController.viewControllers = []
            let media_files = [["image", "macbook"], ["video", "sample_video"], ["image", "ipad"], ["image", "iphone"]]
            for (index, media) in enumerate(media_files) {
                var mediaView = self.storyboard?.instantiateViewControllerWithIdentifier("MapStoryMediaVC") as! MapStoryMediaViewController
                if (index % 2 == 0) {
                    mediaView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
                } else {
                    mediaView.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
                }
                mediaView.mediaUri = media[1]
                if media[0] == "image" {
                    mediaView.mediaType = MapStoryMediaViewController.image_type
                }
                if media[0] == "video" {
                    mediaView.mediaType = MapStoryMediaViewController.video_type
                }
                navController.viewControllers.append(mediaView)
            }
        }
    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        performSegueWithIdentifier("MapStorySegue", sender: nil)
        return true
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            viewMap.myLocationEnabled = true
        }
    }
    
    func imageFromView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.mainScreen().scale)
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func generateMarker(iconImage: UIImage, count: String, location: CLLocationCoordinate2D) -> GMSMarker {
        var marker = GMSMarker()
        
        var view = UIView(frame: CGRectMake(0, 0, 65, 65))
        var pinImageView = UIImageView(image: iconImage)
        
        var label = UILabel()
        label.text = count
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        label.sizeToFit()
        
        pinImageView.center = view.convertPoint(view.center, fromView: view.superview)
        label.center = view.convertPoint(view.center, fromView: view.superview)
        
        view.addSubview(pinImageView)
        view.addSubview(label)
        
        marker.icon = self.imageFromView(view)
        marker.position = location
        marker.opacity = 0.6
        
        return marker
    }

    // MARK: IBAction method implementation
    
    @IBAction func changeMapType(sender: AnyObject) {
        
    }
    
    
    @IBAction func findAddress(sender: AnyObject) {
    
    }
    
    
    @IBAction func createRoute(sender: AnyObject) {
    
    }
    
    
    @IBAction func changeTravelMode(sender: AnyObject) {
    
    }
    
    
}

