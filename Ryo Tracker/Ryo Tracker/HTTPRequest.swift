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
         