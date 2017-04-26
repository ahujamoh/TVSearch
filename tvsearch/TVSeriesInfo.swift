//
//  TVSeriesInfo.swift
//  tvsearch
//
//  Created by Mohit on 24/04/17.
//  Copyright © 2017 ahujamoh. All rights reserved.
//

import UIKit
import Alamofire
import Gloss

class TVSeriesInfo: NSObject {
//    var score: Float = 0.0
//    var name: String!
//    var status: String?
//    var image: String?
//    var previousEpisode: String?
//    var nextEpisode: String?
//    var summary: String?
    
    typealias MazeAPIResponse = (NSError?, [TVSeries]?)->Void
    
    //    class func parseMazeAPIResponse(
    
    class func search(searchText: String!, onCompletion: @escaping MazeAPIResponse)->Void{
        let escapedText: String = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlString: String = "https://api.tvmaze.com/search/shows?q=\(escapedText)"
        
        Alamofire.request(urlString).responseJSON { (response) in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            if response.result.isSuccess{
//                if let JSON = response.result.value {
////                    print("JSON: \(JSON)")
//                }
                var tvshows = [TVSeries]()
                for x in response.result.value as! NSArray{
                    guard let value = x as? JSON,
                        let responseModel = TVSeries(json: value) else {
                            print("responseModel failed")
                            return
                    }
                    print(responseModel.name)
                    print(responseModel)
                    tvshows.append(responseModel)
                }
                print("test")
                onCompletion(nil, tvshows)
            }
            else{
                print("you fucked up: Alamofire says this, I don't")
            }
        }
    }
}

struct TVSeries: Decodable{
    var score: Float = 0.0
    var name: String!
    var status: String?
    var image: String?
//    var previousEpisode: String?
//    var nextEpisode: String?
//    var summary: String?
    
    init?(json: JSON) {
        self.score = ("score" <~~ json)!
        self.name = "show.name" <~~ json
        self.status = "show.status" <~~ json
        self.image = "show.image.medium" <~~ json
        
    }
}
