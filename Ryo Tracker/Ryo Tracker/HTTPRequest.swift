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
            
            let decoder = JSONDecoder()
            let jsonString = response.result.value
            let jsonData = jsonString!.data(using: .utf8)!
            if exchange == exchangeVal.tradeogre.rawValue {
                let ticker = try! decoder.decode(TOTicker.self, from: jsonData)
                tickerResponse(ticker)
            } else if exchange == exchangeVal.maplechange.rawValue {
                let ticker = try! decoder.decode(MCTicker.self, from: jsonData)
                tickerResponse(ticker)
            }
        
            
        }
    }
    
    static func requestTradeBin(exchange: Int, url: String, tradeBinResponse: @escaping (Any) -> Void){
        Alamofire.request(url).responseString { response in
            
            let decoder = JSONDecoder()
            let jsonString = response.result.value
            let jsonData = jsonString!.data(using: .utf8)!
            if exchange == exchangeVal.tradeogre.rawValue {
                
                let tradeBin = try! decoder.decode([TOTradeBin].self, from: jsonData)
                tradeBinResponse(tradeBin)
            } else if exchange == exchangeVal.maplechange.rawValue {
                let tradeBin = try! decoder.decode(MCTradeBin.self, from: jsonData)
                tradeBinResponse(tradeBin)
            }
            
            
        }
    }
    
    static func requestNetworkStatistics(networkResponse: @escaping (NetworkStatistics) -> Void) {
        Alamofire.request("https://ryo.hashvault.pro/api/network/stats").responseString { response in
            let decoder = JSONDecoder()
            let jsonString = response.result.value
            let jsonData = jsonString!.data(using: .utf8)!
            let networkStatistics = try! decoder.decode(NetworkStatistics.self, from: jsonData)
            networkResponse(networkStatistics)
        }
        
    }
    
}
