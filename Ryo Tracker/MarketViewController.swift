
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
            
            // Gets trade bins for chart data
            self.updateCharts()
            
            // Gets instrument data
            HTTPRequest.requestInstrument(symbol: self.symbol) { instruments in
                for instrument in instruments {
                    self.updateLabels(lastPrice: instrument.lastPrice!,
                        mPrice: instrument.markPrice!,
                        bPrice: instrument.bidPrice!,
                        aPrice: instrument.askPrice!,
                        volume: instrument.volume24h!,
                        highPrice: instrument.highPrice!,
                        lowPrice: instrument.lowPrice!)
                }
            }
        }
        
        requestTimer!.fire()

    }
    
    fileprivate func chartSetup() {
        candleStickChartView.chartDescription?.text = symbol
        candleStickChartView.pinchZoomEnabled = true
        candleStickChartView.dragEnabled = true
        candleStickChartView.rightAxis.enabled = false
        candleStickChartView.xAxis.enabled = false
        candleStickChartView.legend.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {