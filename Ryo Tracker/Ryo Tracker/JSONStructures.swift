//
//  JSONStructures.swift
//  tradr
//
//  Created by William Ravenscroft on 09/05/2018.
//  Copyright © 2018 ZypherFX. All rights reserved.
//

import Foundation

struct TOTicker : Codable {
    public var success : Bool
    public var initialprice : String
    public var price : String
    public var high : String
    public var low : String
    public var volume : String
    public var bid : String
    public var ask : String
}

struct TOTradeBin : Codable {
    public var date : Int
    public var type : String
    public var price : String
    public var quantity : String
}

struct MCTicker : Codable {
    public var at : Int?
    struct ticker : Codable {
        public var buy : Double?
        public var sell