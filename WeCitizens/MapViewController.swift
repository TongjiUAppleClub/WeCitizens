//
//  MapViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 4/6/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate{
    
    @IBOutlet weak var MapView: MKMapView!
    
    var voiceList = [Voice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "地图"
        MapView.delegate = self
        MapView.showsUserLocation = true
        if self.voiceList.count > 0 {
            MapView.centerCoordinate = CLLocationCoordinate2D(latitude: voiceList[0].latitude, longitude: voiceList[0].longitude)
        }
        MapView.userTrackingMode = MKUserTrackingMode.Follow
        drawPins()
        cameraSetUp()
        
        print("voice size:\(self.voiceList.count)")
    }
    
    func drawPins() {
        voiceList.forEach { voice in
            let drapPin = MKPointAnnotation()
            drapPin.coordinate = CLLocationCoordinate2DMake(voice.latitude, voice.longitude)
            drapPin.title = "NYC!"
            MapView.addAnnotation(drapPin)
        }
        
    }
    
    private func cameraSetUp() {
      MapView.camera.altitude = 1400
      MapView.camera.pitch = 50
      MapView.camera.heading = 180
    }
    @IBAction func ChangeMapType(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            MapView.mapType = .HybridFlyover
            cameraSetUp()
        default:
            MapView.mapType = .Standard
            cameraSetUp()
        }
        
    }
}
