
//
//  UtilityFunctions.swift
//  Ryo Tracker
//
//  Created by Will Ravenscroft on 28/06/2018.
//  Copyright © 2018 Zypher DX. All rights reserved.
//

import Foundation

func roundUpEnd(date: Date) -> Date {
    var newDate = date
    let minute = Calendar.current.component(.minute, from: date)
    newDate = Calendar.current.date(byAdding: .minute, value: 60-minute, to: newDate)!
    let second = Calendar.current.component(.second, from: date)
    newDate = Calendar.current.date(byAdding: .second, value: -second, to: newDate)!
    return newDate
}

func roundDownStart(date: Date) -> Date {
    var newDate = date
    let minute = Calendar.current.component(.minute, from: date)
    newDate = Calendar.current.date(byAdding: .minute, value: (-minute), to: newDate)!
    let second = Calendar.current.component(.second, from: date)
    newDate = Calendar.current.date(byAdding: .second, value: -second, to: newDate)!
    return newDate
}

// Convert unix time stamp to date
func unixToDate(unixTimeStamp: Int) -> Date {
    return Date(timeIntervalSince1970: Double(unixTimeStamp))
}