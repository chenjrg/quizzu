
//
//  NetworkDataHandling.swift
//  Ryo Tracker
//
//  Created by Will Ravenscroft on 01/07/2018.
//  Copyright © 2018 Zypher DX. All rights reserved.
//

import Foundation

struct StatisticsFormat {
    public var difficulty : Double
    public var hash : String
    public var height : Int
    public var reward : String
    public var timeUTC : String
    
    init(networkStatistics: NetworkStatistics) {
        difficulty = networkStatistics.difficulty!
        hash = networkStatistics.hash!
        height = networkStatistics.height!
        reward = String(networkStatistics.reward!) + "RYO"
        let date = unixToDate(unixTimeStamp: networkStatistics.timeStamp!)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        timeUTC = "\(hour):\(minutes) UTC"
    }
}