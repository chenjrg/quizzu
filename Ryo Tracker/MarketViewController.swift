
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
        super.viewWillDisappear(animated)
        requestTimer?.invalidate()
        requestTimer = nil
    }
    
    private func updateChartData(tradeBins: [TradeBin]) {
        
        let yVals1 = (0..<tradeBins.count).map { (i) -> CandleChartDataEntry in
            let numberVals = tradeBins.count-1
            let high = tradeBins[numberVals-i].high!
            let low = tradeBins[numberVals-i].low!
            let open = tradeBins[numberVals-i].open!
            let close = tradeBins[numberVals-i].close!
            
            return CandleChartDataEntry(x: Double(i), shadowH: high, shadowL: low, open: open, close: close, icon: nil)
        }
        
        let set1 = CandleChartDataSet(values: yVals1, label: "Data Set")
        set1.axisDependency = .left
        set1.setColor(UIColor(white: 80/255, alpha: 1))
        set1.drawIconsEnabled = false
        set1.decreasingColor = .red
        set1.decreasingFilled = true
        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
        set1.increasingFilled = true
        set1.neutralColor = .white
        set1.shadowColorSameAsCandle = true
        set1.drawValuesEnabled = false
        
        let data = CandleChartData(dataSet: set1)
        candleStickChartView.data = data
    }
    
    func updateLabels(lastPrice: Double, mPrice: Double, bPrice: Double, aPrice: Double, volume: Double, highPrice: Double, lowPrice: Double) {
        price.text = formatNumber(number: lastPrice)
        markPrice.text = formatNumber(number: mPrice)
        bidPrice.text = formatNumber(number: bPrice)
        askPrice.text = formatNumber(number: aPrice)
        volume24h.text = formatNumber(number: volume)
        low24h.text = formatNumber(number: lowPrice)
        high24h.text = formatNumber(number: highPrice)
    }
    
    func formatNumber(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        if number < 100000 {
            numberFormatter.locale = Locale(identifier: "en_US_POSIX")
            numberFormatter.numberStyle = NumberFormatter.Style.currency
            let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
            return formattedNumber!
        } else {
            numberFormatter.locale = Locale(identifier: "en_US Locale")
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
            return formattedNumber!
        }
        
    }
    
    @IBAction func instrumentPress(_ sender: UIButton) {
        self.performSegue(withIdentifier: "changeInstrument", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeInstrument" {
            let destination = segue.destination
            if let popController = destination.popoverPresentationController {
                popController.backgroundColor = UIColor.lightGray
                popController.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            interval = timeIntervals[0]
        case 1:
            interval = timeIntervals[1]
        case 2:
            interval = timeIntervals[2]
        case 3:
            interval = timeIntervals[3]
        
        default:
            break
        }
        
        updateCharts()
 
    }
    
    fileprivate func updateCharts() {
        HTTPRequest.requestTradeBins(symbol: self.symbol, interval: self.interval, count: binCount) { tradeBins in