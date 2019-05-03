//
//  ViewController2.swift
//  Task6
//
//  Created by Hou Ping on 01/05/2019.
//  Copyright © 2019 Hou Ping. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//struct Weather {
//    var main:String=""
//    var description:String=""
//    var icon:String=""
//    var id:String=""
//
//}
class ViewController2:UIViewController{
    
    var lat=""
    var long=""
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    //let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    
    let APP_ID = "866c44150e10ff769d1199cbbd8cc98f"
    
    let main=WeatherDataModel()
    let sys=SYS()
    let weather=Weather()
    let weather2=Weather()

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let params:[String:String]=["lat":latitute,"lon":longtitude,"appid":APP_ID]
        getWeatherData(url:WEATHER_URL,parameters:params)
       
        label.text=itemArray[myIndex]
//        label2.text="latitute:\(lat)+: longtitude:\(long)"
//        print(long)
//        print(lat)
        
        if(label2.text! == "Label"){
            label2.text="Unvailable..."
        }
        if(cityLabel.text!=="Label"){
            cityLabel.text="Connection problem, please check."
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destination as! displayController
        //   destinationVC.cloud = _cloud
        destinationVC.lat=lat
        destinationVC.long=long
        
        
        
    }
    
    
    func getWeatherData(url:String,parameters:[String:String]){
        
        Alamofire.request(url,method:.get,parameters:parameters).responseJSON{
            response in
            if response.result.isSuccess{
                let weatherJSON:JSON=JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                
                
            }
            else{
                
                print("Error\(String(describing: response.result.error))")
            }
            
        }
        
    }
    func updateWeatherData(json:JSON){
        if let tempResult=json["main"]["temp"].double{
            //get all the json data here
            let clouds=json["clouds"]["all"].intValue
            let id=json["id"].intValue
            let city=json["name"].stringValue
            let base=json["base"].stringValue
            let dt=json["dt"].intValue //Time of data calculation, unix, UTC
            let visibility=json["visibility"].intValue
            let wind=json["wind"]["speed"].doubleValue
            let code=json["cod"].intValue
            //main section here
            main.humidity=json["main"]["humidity"].intValue
            main.tempMax=json["main"]["temp_max"].doubleValue
            main.temp=json["main"]["temp"].intValue
            main.tempMin=json["main"]["temp_min"].doubleValue
            main.pressure=json["main"]["pressure"].intValue

            //sys section here
            sys.sunset=json["sys"]["sunset"].intValue
            sys.message=json["sys"]["message"].doubleValue
            sys.country=json["sys"]["country"].stringValue
            sys.type=json["sys"]["type"].intValue
            sys.sunrise=json["sys"]["sunrise"].intValue
            sys.id=json["sys"]["id"].intValue


            //weather section here
            weather.main=json["weather"][0]["main"].stringValue
            weather.description=json["weather"][0]["description"].stringValue
            weather.icon=json["weather"][0]["icon"].stringValue
            weather.id=json["weather"][0]["id"].stringValue

            weather2.main=json["weather"][1]["main"].stringValue
            weather2.description=json["weather"][1]["description"].stringValue
            weather2.icon=json["weather"][1]["icon"].stringValue
            weather2.id=json["weather"][1]["id"].stringValue


            cityLabel.text=city
            
            
            
            //Update the UILabel
            switch myIndex {
            case 0:
               label2.text=String(clouds)
            case 1:
                label2.text=String(id)
            case 2:
                label2.text=String(city)
            case 3:
                label2.text=String(base)
            case 4:
                label2.text=String("Humidity:\(main.humidity) \n TempMax:\(main.tempMax)\n Temp:\(main.temp) \n TempMin:\(main.tempMin) \n pressure:\(main.pressure)")
            case 5:
                label2.text=String("Longtitute:\(long)")
            case 6:
                label2.text=String(dt)
            case 7:
                label2.text=String(visibility)
            case 8:
                label2.text=String("Sunset:\(sys.sunset)\n Message:\(sys.message)\n Country:\(sys.country)\n Type:\(sys.type)\n Sunrise:\(sys.sunrise)\n ID:\(sys.id)\n  ")
            case 9:
                label2.text=String(wind)
            case 10:
                label2.text=String("Main:\(weather.main)\n Description:\(weather.description)\n Icon:\(weather.icon)\n ID:\(weather.id)\n \n  Main:\(weather2.main)\n Description:\(weather2.description)\n Icon:\(weather2.icon)\n ID:\(weather2.id)\n")
            case 11:
                label2.text=String(code)
            default:
                label2.text="coming soon"
            }
         
        }
        
        
        
    }
}
