//
//  StructViewController.swift
//  Task-APi-Intergration-POST-3
//
//  Created by Ananth Nair on 17/08/23.
//

import UIKit

struct Root : Codable {
    var locationList : [String?]
    var vehicleInfo : vehicleInfo?
}

struct vehicleInfo : Codable {
    
    var make : String?
    var model : String?
    var varient : String?
    var segment : String?
    var year : Int?
}
