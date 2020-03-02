
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