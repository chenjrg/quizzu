
//
//  ViewController.swift
//  Ryo Tracker
//
//  Created by Will Ravenscroft on 06/06/2018.
//  Copyright © 2018 Zypher DX. All rights reserved.
//

import UIKit
import Charts

class MarketController: UIViewController {

    @IBOutlet weak var candleStickChartView: CandleStickChartView!
    private var exchange = Exchange.init()
    fileprivate var requestTimer: Timer?
    
    // Ticker labels
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bidLabel: UILabel!
    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    //percentage change
    
    @IBOutlet weak var changeLabel: UILabel!
    //generic vars
    var toTicker: TOTicker!
    private var percentChange = 0.0
    public var inputLabel: UILabel?
    public var chartData: OHLCForm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeLabel.text = inputLabel?.text
        changeLabel.textColor = inputLabel?.textColor
        
        chartSetup()
        
        if chartData != nil {
            updateChartData(ohlcForm: chartData!)
        }
        
        // Send HTTP requests every 10 seconds to update data
        requestTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            
            self.updateCharts()
            
            HTTPRequest.requestTicker(exchange: self.exchange.getExchange(), url: self.exchange.getTickerURL()) {ticker in
                if self.exchange.getExchange() == exchangeVal.tradeogre.rawValue {
                    let toTicker = ticker as! TOTicker
                    self.priceLabel.text = "฿ "+toTicker.price