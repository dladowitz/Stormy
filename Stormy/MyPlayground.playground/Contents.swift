//: Playground - noun: a place where people can play

import UIKit

let apiKey = "0758afcef711ec228b107286e9686e36"
let coordinates = "37.8267,-122.423"
let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
let forecastURL = NSURL(string: coordinates, relativeToURL: baseURL)

