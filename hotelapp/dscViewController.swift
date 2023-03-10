//
//  dscViewController.swift
//  hotelapp
//
//  Created by Subhransu Siddhant Sagar on 22/02/23.
//
//it has always been a pleasure to work like thius 
//
//

import UIKit
import Foundation

class dscViewController: UIViewController, UITableViewDataSource {
    var hList :[harray]=[]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cid", for: indexPath)
        let htl = hList[indexPath.row]
        cell.textLabel?.text = htl.regionNames?.shortName!
        return cell
    }
    
    
    
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    @IBAction func searchClicked(_ sender: UIButton, forEvent event: UIEvent) {
        
        
        let anyfunc = {
            (apicondata:[harray]) in
            DispatchQueue.main.async {
                self.hList = apicondata
                self.searchTableView.reloadData()
            }
        }
            self.apicon(onCompletion: anyfunc)
        
        //apicon()
        //self.searchTableView.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        searchTableView.dataSource = self
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cid")
        
        
        
        
    }
    
    func apicon(onCompletion:@escaping ([harray]) -> ())  {
        let place = locationTextField.text
        let fplace = place!.replacingOccurrences(of: " ", with: "%20")
        
        
        let headers = [
            "X-RapidAPI-Key": "85f161018fmshd7e425038798bcdp18f479jsn1a4ed75b73e0",
            "X-RapidAPI-Host": "hotels4.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: URL(string:"https://hotels4.p.rapidapi.com/locations/v3/search?q=\(fplace)&locale=en_US&langid=1033&siteid=300000001")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request ) { data, response, error in
          
            if (error != nil) {
                print(error?.localizedDescription)
            } else {
                print(response)
            }
            if let data = data {
                guard let mydata = try? JSONDecoder().decode(colec.self, from: data) else{
                    print("can not decode")
                    return
                }
        
                
                
               onCompletion(mydata.sr)
    
                
    
            }
        }
        
        dataTask.resume()
        
    }
    
}

    
    
    
    struct colec:Codable{
        let q:String?
        let rid:String?
        let sr:[harray]
    }
    
    struct harray:Codable{
        let regionNames:details?
     
    }
    
    struct details:Codable{
        let fullName:String?
        let shortName:String?
        let displayName:String?
        let primaryDisplayName:String?
        let secondaryDisplayName:String?
        let lastSearchName:String?
    }
    
    
    /*
     
     {
     "@type":"gaiaRegionResult",
     "index":"0",
     "gaiaId":"2621",
     "type":"CITY",
     "regionNames":{
     "fullName":"New York, New York, United States of America",
     "shortName":"New York",
     "displayName":"New York, New York, United States",
     "primaryDisplayName":"New York",
     "secondaryDisplayName":"New York, United States",
     "lastSearchName":"New York"
     },
     "essId":{
     "sourceName":"GAI",
     "sourceId":"2621"
     },
     "coordinates":{
     "lat":"40.712843",
     "long":"-74.005966"
     },
     "hierarchyInfo":{
     "country":{
     "name":"United States",
     "isoCode2":"US",
     "isoCode3":"USA"
     }
     }
     },
     
     
     {
     "q":"new york",
     "rid":"41db7ac83b884d948077bdcc1a3ba048",
     "rc":"OK",
     "sr":[
     {},
     {},
     {},
     {},
     {},
     {},
     {},
     {},
     {},
     {}
     ]
     }
     
     
     
     */

