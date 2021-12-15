
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