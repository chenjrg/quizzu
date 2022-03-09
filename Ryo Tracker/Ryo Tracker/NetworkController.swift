//
//  NetworkController.swift
//  Ryo Tracker
//
//  Created by Will Ravenscroft on 01/07/2018.
//  Copyright © 2018 Zypher DX. All rights reserved.
//

import UIKit

class NetworkController: UIViewController {

    @IBOutlet weak var changeLabel: UILabel!
    public var inputLabel: UILabel?
    public var chartData: OHLCForm?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changeLabel.text = inputLabel?.text
        changeLabel.textColor = inputLabel?.textColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let marketController = segue.destination as? MarketController {
            marketController.inputLabel = changeLabel
            marketController.chartData = chartData
        }
        if let newsController = segue.destination as? NewsController {
            newsController.inputLabel = changeLabel
            newsController.chartData = chartData
        }
    }
    

}
