
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
                    self.bidLabel.text = "฿ "+toTicker.bid
                    self.askLabel.text = "฿ "+toTicker.ask
                    self.highLabel.text = "฿ "+toTicker.high
                    self.lowLabel.text = "฿ "+toTicker.low
                    self.volumeLabel.text = "฿ "+toTicker.volume
                    let tPrice = Double(toTicker.price)!
                    let tInitialPrice = Double(toTicker.initialprice)!
                    
                    self.percentChange = 100.0*(tPrice/tInitialPrice-1.0)
                    if self.percentChange >= 0 {
                        self.changeLabel.text = String(" +" + String(format: "%.2f",self.percentChange) + "%")
                        self.changeLabel.textColor = UIColor.init(red: 39, green: 146, blue: 4, alpha: 256)
                        
                    } else {
                        self.changeLabel.text = String(" " + String(format: "%.2f", self.percentChange) + "%")
                        self.changeLabel.textColor = UIColor.red
                    }
                    
                }
            }
            
            
            
        }
        
        requestTimer!.fire()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newsController = segue.destination as? NewsController {
            newsController.inputLabel = changeLabel
            newsController.chartData = chartData
        }
        if let networkController = segue.destination as? NetworkController {
            networkController.inputLabel = changeLabel
            networkController.chartData = chartData
        }
    }
    
    fileprivate func chartSetup() {
        candleStickChartView.chartDescription?.text = "RYO-BTC"
        candleStickChartView.pinchZoomEnabled = true
        candleStickChartView.dragEnabled = true
        candleStickChartView.rightAxis.enabled = false
        candleStickChartView.xAxis.enabled = false
        candleStickChartView.legend.enabled = false
    }
    
    func updateChartData(ohlcForm: OHLCForm) {
        
        let yVals1 = (0..<ohlcForm.length-1).map { (i) -> CandleChartDataEntry in
            let high = ohlcForm.high[i]
            let low = ohlcForm.low[i]
            let open = ohlcForm.open[i]
            let close = ohlcForm.close[i]
            
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
        set1.neutralColor = .darkGray
        set1.shadowColorSameAsCandle = true
        set1.drawValuesEnabled = false
        
        let data = CandleChartData(dataSet: set1)
        candleStickChartView.data = data
    }
   
    private func updateCharts() {
        HTTPRequest.requestTradeBin(exchange: self.exchange.getExchange(), url: self.exchange.getTradeBinURL()) { tradeBin in
            if self.exchange.getExchange() == exchangeVal.tradeogre.rawValue {
                let toTradeBin = tradeBin as! [TOTradeBin]
                let timeBucket = HourlyTimeBucket.init(tradeBin: toTradeBin, size: 50)
                let ohlcForm = OHLCForm.init(hourlyBucket: timeBucket)
                self.updateChartData(ohlcForm: ohlcForm)
                self.chartData = ohlcForm
            }
        }
    }


}
