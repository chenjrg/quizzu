//
//  HTTPRequests.swift
//  tradr
//
//  Created by William Ravenscroft on 09/05/2018.
//  Copyright © 2018 ZypherFX. All rights reserved.
//

import Foundation
import Alamofire

class HTTPRequest {
    
    //Ticker
    static func requestTicker(exchange: Int, url: String, tickerResponse: @escaping (Any) -> Void){
        Alamofire.request(url).responseString { response in
            
            let decoder = JSO