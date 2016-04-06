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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
        MapView.showsUserLocation = true
        MapView.userTrackingMode = MKUserTrackingMode.Follow
        drawPins([])
        cameraSetUp()
    }
    
    func drawPins(pins:[CLLocationCoordinate2D])
    {
        //TODO:- 写个循环，一个个的加
        let drapPin = MKPointAnnotation()
        drapPin.coordinate = CLLocationCoordinate2DMake(40.730872, -74.003066)
        drapPin.title = "NYC!"
        MapView.addAnnotation(drapPin)
    }
    
    private func cameraSetUp()
    {
      MapView.camera.altitude = 1400
      MapView.camera.pitch = 50
      MapView.camera.heading = 180
    }
    @IBAction func ChangeMapType(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 1:
            MapView.mapType = .HybridFlyover
            cameraSetUp()
        default:
            MapView.mapType = .Standard
            cameraSetUp()
        }
        
    }
}
