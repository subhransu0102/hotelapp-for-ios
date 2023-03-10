//
//  APICaller.swift
//  hotelapp
//
//  Created by Subhransu Siddhant Sagar on 10/02/23.
//

import Foundation




class APICaller {
     var isPagination = false
    func fetchData(pagination:Bool = false, completion: @escaping (Result<[String],Error>) -> Void) {
        if pagination{
            isPagination = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
            let data = [
            
                "hotel1",
                "hotel2",
                "hotel3",
                "hotel4",
                "hotel5",
                "hotel6",
                "hotel7",
                "hotel8",
                "hotel9",
                "hotel10",
                "hotel11",
                "hotel12",
                "hotel13",
                "hotel14",
                "hotel15",
            
            ]
            completion(.success(data))
            if pagination{
                self.isPagination = false
            }
        })
    }
}
