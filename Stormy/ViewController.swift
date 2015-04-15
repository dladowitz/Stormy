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
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var percipitationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
//  https://developer.forecast.io/ reset periodically if left in git repository
    private let apiKey = "0758afcef711ec228b107286e9686e36"

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshActivityIndicator.hidden = true
        getWeatherData()
    }
    
    func getWeatherData(){
        let coordinates = "37.8267,-122.423"
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: coordinates, relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!,
            completionHandler:{(location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
                if error == nil {
                    let dataObject = NSData(contentsOfURL: location)
                    let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as! NSDictionary
                    //                    println(weatherDictionary)
                    
                    let currentWeather = Current(weatherDictionary: weatherDictionary)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.temperatureLabel.text = "\(currentWeather.temperature)"
                        self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                        self.iconView.image = currentWeather.icon!
                        self.humidityLabel.text = "\(currentWeather.humidity)"
                        self.percipitationLabel.text = "\(currentWeather.precipProbability)"
                        self.summaryLabel.text = currentWeather.summary
                    })
                }
                
            }
        )
        downloadTask.resume()
        refreshActivityIndicator.stopAnimating()
        refreshActivityIndicator.hidden = true
        refreshButton.hidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refresh() {
        refreshButton.hidden = true
        refreshActivityIndicator.hidden = false
        refreshActivityIndicator.startAnimating()
        getWeatherData()
    }

}

