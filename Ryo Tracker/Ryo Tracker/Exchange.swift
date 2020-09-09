
//
//  File.swift
//  Ryo Tracker
//
//  Created by Will Ravenscroft on 19/06/2018.
//  Copyright © 2018 Zypher DX. All rights reserved.
//

import Foundation

public enum exchangeVal: Int {
    case tradeogre = 0
    case maplechange = 1
}

public class Exchange {
    
    private var URLS = ["https://tradeogre.com/api/v1","https://maplechange.com//api/v2"]
    private var tradeBinURLS = ["https://tradeogre.com/api/v1/history/BTC-RYO"]
    private var tickerURLS = ["https://tradeogre.com/api/v1/ticker/BTC-RYO","https://maplechange.com:443//api/v2/tickers/ryobtc.json"]
    private var exchangeNames = ["TRADEOGRE","MapleChange"]
    private var exchange: Int
    
    init() {
        exchange = exchangeVal.tradeogre.rawValue
    }
    
    public func getBaseURL() -> String {
        return URLS[exchange]
    }
    
    public func getTradeBinURL() -> String {
        return tradeBinURLS[exchange]
    }
    
    public func getTickerURL() -> String {
        return tickerURLS[exchange]
    }
    
    public func getExchangeName() -> String {
        return exchangeNames[exchange]
    }
    
    public func getExchange() -> Int {
        return exchange
    }