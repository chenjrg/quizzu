
//
//  ViewController.swift
//  tradr
//
//  Created by William Ravenscroft on 07/05/2018.
//  Copyright © 2018 ZypherFX. All rights reserved.
//

import UIKit
import Charts

class MarketViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var candleStickChartView: CandleStickChartView!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var markPrice: UILabel!
    @IBOutlet weak var bidPrice: UILabel!
    @IBOutlet weak var askPrice: UILabel!
    @IBOutlet weak var volume24h: UILabel!
    @IBOutlet weak var high24h: UILabel!
    @IBOutlet weak var low24h: UILabel!
    
    fileprivate var requestTimer: Timer?
    
    fileprivate var symbol = "XBTUSD"
    fileprivate var timeIntervals = ["1d","1h","5m","1m"]
    fileprivate var interval = "1h"
    fileprivate var binCount = 75
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        chartSetup()
        
        // Send HTTP requests every 10 seconds to update data
        requestTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in