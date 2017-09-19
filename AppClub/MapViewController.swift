//
//  MapViewController.swift
//  AppClub
//
//  Created by Local Admin on 7/31/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var myMapView: MKMapView!
    var locationManager: CLLocationManager!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
let initialLocation = CLLocation(latitude: 46.728197, longitude: -117.1660672)
        let latDelta: CLLocationDegrees = 0.003
        let lonDelta: CLLocationDegrees = 0.003
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 46.728193, longitude: -117.1660672)
        let latitude = 46.728197
        let longitude = -117.1660672
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMapView.addAnnotation(annotation)
        self.myMapView.setRegion(region, animated: true)
        // Do any additional setup after loading the view.
        var timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: Selector("loadLocation"), userInfo: nil, repeats: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadLocation(){
        let getLocation = PostFunctions()
        let defaults = UserDefaults.standard
        getLocation.GetLocation()
        locationLabel.text = defaults.string(forKey: "MeetingLocation")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
