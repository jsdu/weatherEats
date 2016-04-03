//
//  ViewController.swift
//  weatherEats
//
//  Created by Jason Du on 2016-04-01.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet var detailCategory: UILabel!
    @IBOutlet var detailName: UILabel!
    @IBOutlet var detailAddress: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    var cloudyDict = [String:Int]()
    var rainyDict = [String:Int]()
    var clearDict = [String:Int]()
    var snowyDict = [String:Int]()

    let locationManager = CLLocationManager()
    
    var filter = "all"
    var markerArr:[CustomPointAnnotation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
//        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        if let path = NSBundle.mainBundle().pathForResource("businessData", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as! NSArray
                    for results in jsonResult {
                        let newMarker = CustomPointAnnotation()
                        
                        if let category = results["categories"] as? [String] {
                            if (!category.contains("Restaurants") && !category.contains("Food")){
                                continue
                            }
                            newMarker.category = category
                        }
                        
                        if let state = results["state"] as? String {
                            if (state != "QC") {
                                continue
                            }
                        }
                        
                        var lat = 0.0
                        var lon = 0.0
                        
                        if let latitude = results["latitude"] as? Double{
                            lat = latitude
                        }
                        if let longitude = results["longitude"] as? Double {
                            lon = longitude
                        }
                        
                        newMarker.coordinate = CLLocationCoordinate2DMake(lat, lon)
                        
                        if let weather = results["weather"] as? String {
                            if (weather == "clear") {
                                newMarker.imageName = "markerSun"
                                
                                for items in newMarker.category! {
                                    if (clearDict[items] == nil) {
                                        clearDict[items] = 1
                                    } else {
                                        clearDict[items]! += 1
                                    }
                                }
                            } else if (weather == "rain") {
                                newMarker.imageName = "markerRain"
                                
                                for items in newMarker.category! {
                                    if (rainyDict[items] == nil) {
                                        rainyDict[items] = 1
                                    } else {
                                        rainyDict[items]! += 1
                                    }
                                }
                            } else if (weather == "cloudy") {
                                newMarker.imageName = "markerCloud"
                                
                                for items in newMarker.category! {
                                    if (cloudyDict[items] == nil) {
                                        cloudyDict[items] = 1
                                    } else {
                                        cloudyDict[items]! += 1
                                    }
                                }
                            } else if (weather == "snow") {
                                newMarker.imageName = "markerSnow"
                                
                                for items in newMarker.category! {
                                    if (snowyDict[items] == nil) {
                                        snowyDict[items] = 1
                                    } else {
                                        snowyDict[items]! += 1
                                    }
                                }
                            } else {
                                newMarker.imageName = "noImage"
                            }
                        }
                        
                        if let name = results["name"] as? String {
                            newMarker.name = name
                        }
                        
                        if let address = results["full_address"] as? String {
                            newMarker.address = address
                            newMarker.title = address
                        }
                        
                        markerArr.append(newMarker)
                        if (newMarker.imageName == "markerCloud") {
                            self.mapView.addAnnotation(newMarker)
                        }
                    }
                    //print(cloudyDict)
                    let byValue = {
                        (elem1:(key: String, val: Int), elem2:(key: String, val: Int))->Bool in
                        if elem1.val < elem2.val {
                            return true
                        } else {
                            return false
                        }
                    }
                    let sortedDict = clearDict.sort(byValue)
                    print(sortedDict)
                    //let sortedDict2 = rainyDict.sort(byValue)
                    //print(sortedDict2)

                } catch {
                    print("error2!")
                }
            } catch {
                print("error!")
            }
            

        }
        
    }
    
    @IBAction func clearPressed(segue:UIStoryboardSegue) {
        mapView.removeAnnotations(mapView.annotations)
        for markers in markerArr {
            if (markers.imageName == "markerSun") {
                self.mapView.addAnnotation(markers)
            }
        }
    }
    
    @IBAction func cloudyPressed(segue:UIStoryboardSegue) {
        mapView.removeAnnotations(mapView.annotations)
        for markers in markerArr {
            if (markers.imageName == "markerCloud") {
                self.mapView.addAnnotation(markers)
            }
        }
    }
    
    @IBAction func rainyPressed(segue:UIStoryboardSegue) {
        mapView.removeAnnotations(mapView.annotations)
        for markers in markerArr {
            if (markers.imageName == "markerRain") {
                self.mapView.addAnnotation(markers)
            }
        }
    }
    
    @IBAction func snowyPressed(segue:UIStoryboardSegue) {
        mapView.removeAnnotations(mapView.annotations)
        for markers in markerArr {
            if (markers.imageName == "markerSnow") {
                self.mapView.addAnnotation(markers)
            }
        }
    }
    
    @IBAction func allPressed(segue:UIStoryboardSegue) {
        mapView.removeAnnotations(mapView.annotations)
        for markers in markerArr {
            self.mapView.addAnnotation(markers)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = false
        }
        else {
            anView!.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomPointAnnotation
        anView!.image = UIImage(named:cpa.imageName)
        return anView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let customAnnot = view.annotation as! CustomPointAnnotation
        detailName.text = customAnnot.name!
        let stringRepresentation = customAnnot.category!.joinWithSeparator(", ") // "1-2-3"
        detailCategory.text = stringRepresentation
        detailAddress.text = customAnnot.address!
        
        print(customAnnot.address!)
        print(customAnnot.category!)
        print(customAnnot.name!)
    }
}

extension ViewController: CLLocationManagerDelegate {
    // 2
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
        
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
}


