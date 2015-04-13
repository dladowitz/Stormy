//
//  ViewController.swift
//  Stormy
//
//  Created by David Ladowitz on 4/12/15.
//  Copyright (c) 2015 David Ladowitz. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
//  https://developer.forecast.io/ reset periodically if left in git repository
    private let apiKey = "0758afcef711ec228b107286e9686e36"

    override func viewDidLoad() {
        super.viewDidLoad()

        let coordinates = "37.8267,-122.423"
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: coordinates, relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!,
            completionHandler:{(location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
                if error == nil {
                    let dataObject = NSData(contentsOfURL: location)
                    let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as! NSDictionary
                    println(weatherDictionary)
                }

            }
        )
        downloadTask.resume()
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

