//
//  hotelAPI.swift
//  hotelapp
//
//  Created by Subhransu Siddhant Sagar on 21/02/23.
//

import Foundation

final class hotelAPI{
    static let shared = hotelAPI()  
    
    func fetchhotellist(onCompletion:@escaping ([hotel]) -> ())  {
    let urlString = "https://www.amiiboapi.com/api/amiibo"
    let url = URL(string: urlString)!
    
    let task = URLSession.shared.dataTask(with: url) { Data, resp, error in
        guard let Data = Data else {
            print("data was nil")
            return
        }
        
        guard let hotelData = try? JSONDecoder().decode(hotelData.self, from: Data) else{
            print("can not decode")
            return
        }
        onCompletion(hotelData.amiibo)
    
        
        
    } 
    task.resume()
}
    
}
    
    
    

struct hotelData:Codable{
    let amiibo:[hotel]
}

struct hotel:Codable {
    
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image:String
    let name:String
    let release:AmiboRe
    let tail: String
    let type:String 
         
    }
    
    struct AmiboRe:Codable{
    let au: String?
    let eu:String?
    let jp:String?
    let na:String?
    }
    



//{
//"amiibo": [
//    {
//        "amiiboSeries": "Super Smash Bros.",
//        "character": "Mario",
//        "gameSeries": "Super Mario",
//        "head": "00000000",
//        "image": "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000000-00000002.png",
//        "name": "Mario",
//        "release": {
//            "au": "2014-11-29",
//            "eu": "2014-11-28",
//            "jp": "2014-12-06",
//            "na": "2014-11-21"
//        },
//        "tail": "00000002",
//        "type": "Figure"
//    },
//    {
//        "amiiboSeries": "Super Mario Bros.",
//        "character": "Mario",
//        "gameSeries": "Super Mario",
//        "head": "00000000",
//        "image": "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000000-00340102.png",
//        "name": "Mario",
//        "release": {
//            "au": "2015-03-21",
//            "eu": "2015-03-20",
//            "jp": "2015-03-12",
//            "na": "2015-03-20"
//        },
//        "tail": "00340102",
//        "type": "Figure"
//    }
//]
//}
