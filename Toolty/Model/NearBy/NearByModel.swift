//
//  NearByModel.swift
//  Toolty
//
//  Created by Suraj on 19/07/21.
//

import Foundation



// MARK: - locationData
struct locationData:Decodable {
    var results: [Result]
    var status: String?
    
    enum CodingKeys: String, CodingKey {
            case results, status
        }
}
struct Result:Decodable {
    var geometry: Geometry
    
    enum CodingKeys: String, CodingKey {
            case geometry
        }
}
struct Geometry:Decodable {
    var location: Location
    enum CodingKeys: String, CodingKey {
            case location
        }
}
struct Location:Decodable {
    var lat, lng: Double?
    enum CodingKeys: String, CodingKey {
            case lat
            case lng
        }
}


struct LocationnameString {
    let color:UIColor
    let name:String
}
