//
//  ViewController.swift
//  Task6
//
//  Created by Hou Ping on 22/04/2019.
//  Copyright © 2019 Hou Ping. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import SwiftyJSON
//MARK: - Declare all GLOBAL variable here
/***************************************************************/

//Write the table method here:
var myIndex=0
var text=""
let itemArray=["Cloudiness","City ID","City Name","Internal parameter","Weather Data","Coordinate","Data calculation Time","Visibility","Sys","Wind","Weather condition Codes","Codes"]
var latitute=""
var longtitude=""
/***************************************************************/


class ViewController: UITableViewController,CLLocationManagerDelegate {
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    //let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    
    let APP_ID = "866c44150e10ff769d1199cbbd8cc98f"
    
    //TODO: Declare instance variables here
    let locationManager=CLLocationManager()
    
    

    
    //Pre-linked IBOutlets
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:Set up the location manager here.
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //MARK: - Tableview Datasource Method
    /***************************************************************/
    
    //Write the table method here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "tableView", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex=indexPath.row
        //case statement here
        //when press the cell, it turns to grey and back to white
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let destinationVC=ViewController2()
//        destinationVC.cloud=cloudSegue
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(url:String,parameters:[String:String]){
        
        Alamofire.request(url,method:.get,parameters:parameters).responseJSON{
            response in
            if response.result.isSuccess{
                print("Success getting the weather data")
                let weatherJSON:JSON=JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
    
            }
            else{
                
                print("Error\(String(describing: response.result.error))")
            }
            
        }
        
    }
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    
    func updateWeatherData(json:JSON){
        if let tempResult=json["main"]["temp"].double{
       
        let clouds=json["clouds"]["all"].int
        print(clouds!)
            
        }
        
     
        
    }
    //MARK: - Segue pass data
    /***************************************************************/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destination as! ViewController2
     //   destinationVC.cloud = _cloud
        destinationVC.lat=latitute
        destinationVC.long=longtitude
        
    }
    


    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location=locations[locations.count-1]
        if location.horizontalAccuracy>0{
            locationManager.stopUpdatingLocation()
            locationManager.delegate=nil
            print("longtitude=\(location.coordinate.longitude),latitude=\(location.coordinate.latitude)")
             latitute=String(location.coordinate.latitude)
             longtitude=String(location.coordinate.longitude)
            
            let params:[String:String]=["lat":latitute,"lon":longtitude,"appid":APP_ID]
            getWeatherData(url:WEATHER_URL,parameters:params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did fail with error")
        print(error)
        
    }
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    
    
    //Write the PrepareForSegue Method here
    
    
    
}

