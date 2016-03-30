//
//  CityModel.swift
//  WeCitizens
//
//  Created by Teng on 3/27/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class CityModel: DataModel {
    
    //获取城市列表
    func getCityList(queryNum:Int, queryTimes: Int, resultHandler: ([City]?, NSError?) -> Void) {
        let query = PFQuery(className: "Cities")
        
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if nil == error {
                print("Successfully retrieved \(objects!.count) cities.")
                
                if let results = objects {
                    var cities = [City]()
                    
                    for result in results {
                        let name = result.objectForKey("cityName") as! String
                        
                        let newCity = City(cityName: name)
                        
                        cities.append(newCity)
                    }
                    resultHandler(cities, nil)
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
        }
    }
}