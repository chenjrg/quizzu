
//
//  MarketDataHandling.swift
//  Ryo Tracker
//
//  Created by Will Ravenscroft on 26/06/2018.
//  Copyright © 2018 Zypher DX. All rights reserved.
//

import Foundation

struct OHLCForm {
    public var length: Int
    public var date: [Date]
    public var open: [Double]
    public var high: [Double]
    public var low: [Double]
    public var close: [Double]
    
    init(hourlyBucket: HourlyTimeBucket) {
        length = hourlyBucket.length
        date = Array(repeating: Date.init(), count: length)
        open = Array(repeating: 0.0, count: length)
        high = Array(repeating: 0.0, count: length)
        low = Array(repeating: 0.0, count: length)
        close = Array(repeating: 0.0, count: length)
        for i in 0...length-1 {
            date[i] = hourlyBucket.bucketStartDate[i]
            open[i] = hourlyBucket.pricesBin[i][0]
            high[i] = hourlyBucket.pricesBin[i].max()!
            low[i] = hourlyBucket.pricesBin[i].min()!
            close[i] = hourlyBucket.pricesBin[i][hourlyBucket.pricesBin[i].count-1]
        }
    }
}

struct HourlyTimeBucket {
    public var length : Int
    public var bucketHour : [Int]
    public var bucketStartDate : [Date]
    public var bucketEndDate : [Date]
    public var pricesBin : [[Double]]
    
    init (tradeBin: [TOTradeBin], size: Int) {
        length = size
        bucketHour = Array(repeating: 0, count: size)
        bucketStartDate = Array(repeating: roundDownStart(date: Date.init()), count: size)
        bucketEndDate = Array(repeating: roundUpEnd(date: Date.init()), count: size)
        pricesBin = Array(repeating: [0.0], count: size)
        let anHour = 3600.0
        let timeScale = -Double((size-1))*anHour
        
        for i in 0...size-1 {
            bucketHour[i] = i+1
            bucketStartDate[i] = bucketStartDate[size-1].addingTimeInterval(timeScale+Double(i)*anHour)
            bucketEndDate[i] = bucketEndDate[size-1].addingTimeInterval(timeScale+Double(i)*anHour)
            var firstLoop = true
            
            for trade in tradeBin {
                let tradeDate = unixToDate(unixTimeStamp: trade.date)
                if tradeDate < bucketStartDate[i] { continue }
                if tradeDate >= bucketEndDate[i] { continue }
                if tradeDate >= bucketStartDate[i] && tradeDate < bucketEndDate[i] {
                    if firstLoop == true {