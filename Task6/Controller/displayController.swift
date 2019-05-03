//
//  displayController.swift
//  Task6
//
//  Created by Hou Ping on 03/05/2019.
//  Copyright © 2019 Hou Ping. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class displayController: UIViewController {
    var lat=""
    var long=""

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(lat != ""){
        let location=CLLocationCoordinate2DMake(Double(lat)!, Double(long)!)
            let span=MKCoordinateSpan(latitudeDelta: 0.002,longitudeDelta: 0.002)
            let region=MKCoordinateRegion(center: location,span: span)
            map.setRegion(region, animated: true)



        }
    }
    
    
}

