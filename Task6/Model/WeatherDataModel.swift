//
//  WeatherDataModel.swift
//  Task6
//
//  Created by Hou Ping on 01/05/2019.
//  Copyright © 2019 Hou Ping. All rights reserved.
//

import Foundation

class WeatherDataModel{
    
    var humidity:Int=0
    var tempMax:Double=0
    var temp:Int=0
    var tempMin:Double=0
    var pressure:Int=0
    
}

class SYS{
    var sunset:Int=0
    var message:Double=0
    var country:String=""
    var type:Int=0
    var sunrise:Int=0
    var id:Int=0
}

class Weather{
    var main:String=""
    var description:String=""
    var icon:String=""
    var id:String=""
    
}
