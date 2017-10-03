//
//  VideoFile.swift
//  movie3
//
//  Created by 小川秀哉 on 2017/09/28.
//  Copyright © 2017年 Digital Circus Inc. All rights reserved.
//aaaaaaaaaaaaaaaaaaaaaaaaaa

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class VideoFile: Mappable, CustomStringConvertible {
    
    var id: Int?
    var title: String?
//    var video: String?
    var video: NSURL?
//    var screenshot_url: NSURL?
    
    var description: String {
        return "title: \(self.title), video: \(self.video)"
//        , screenshot_url: \(self.screenshot_url)
    }
    
    
    init(title: String, video: NSURL) {
        self.title = title
        self.video = video
//    self.screenshot_url = screenshot_url
       
    }
    
    required init?(map: Map) {
      
    }
    
    func mapping(map: Map) {
        
        
        id    <- map["id"]
        title <- map["title"]
        
        let urlTransform = TransformOf<NSURL, String>(fromJSON: { (value: String?) -> NSURL? in
            if let value = value { return NSURL(string: value) } else { return nil }
        }, toJSON: { (value: NSURL?) -> String? in
            return value?.absoluteString
        })
        video <- (map["video"], urlTransform)
//        video <- map["video"]
        /*
        
 
       
        screenshot_url <- (map["screenshot_url"], urlTransform)
        */
        print(3333)
    }
    
    class func getVideoFiles(success: @escaping ([VideoFile]) -> Void, failure: @escaping (NSError?) -> Void) {
        Alamofire.request("http://localhost:3000/articles.json").responseJSON { response in
            if let error = response.result.error {
                failure(error as NSError)
                return
            }
            let json = JSON(response.result.value!)
            let videofiles: [VideoFile] = json.arrayValue.map{videofileJson -> VideoFile in
                return Mapper<VideoFile>().map(JSON: videofileJson.dictionaryObject!)!
            }
            success(videofiles)
            print(videofiles)
            return
        }
    }
}

