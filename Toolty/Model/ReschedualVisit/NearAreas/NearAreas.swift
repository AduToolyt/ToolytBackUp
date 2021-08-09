//
//  NearAreas.swift
//  Toolty
//
//  Created by Chirag Patel on 28/07/21.
//

import Foundation
import UIKit

class NearPlaces{
    var icon : String
    var place_id : String
    var name : String
    var detailedAddress : String
    var geoMetryLocation : Locations?
    
    var iconUrl : URL?{
        return URL(string: icon)
    }
    
    init(dict: NSDictionary) {
        if let dictData = dict["geometry"] as? NSDictionary{
            if let locationDict = dictData["location"] as? NSDictionary{
                self.geoMetryLocation = Locations(dict: locationDict)
            }
        }
        icon = dict.getStringValue(key: "icon")
        place_id = dict.getStringValue(key: "place_id")
        name = dict.getStringValue(key: "name")
        detailedAddress = dict.getStringValue(key: "vicinity")
    }
}

class Locations{
    var lat : Double
    var long : Double
    
    init(dict: NSDictionary) {
        lat = dict.getDoubleValue(key: "lat")
        long = dict.getDoubleValue(key: "lng")
    }
}
