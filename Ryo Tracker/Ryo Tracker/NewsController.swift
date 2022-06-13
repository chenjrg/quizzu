//
//  NewsController.swift
//  Ryo Tracker
//
//  Created by Will Ravenscroft on 28/06/2018.
//  Copyright © 2018 Zypher DX. All rights reserved.
//

import UIKit

class NewsController: UIViewController {
    
    @IBOutlet weak var changeLabel: UILabel!
    public var inputLabel: UILabel?
    
    //data storage for view change
    public var chartData: OHLCForm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        changeLabel.textColor = inputLabel?.textColor
        changeLabel.text = inputLabel?.text
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let marketController = segue.destination as? MarketController {
            marketController.inputLabel = changeLabel
            marketController.chartData = chartData
        }
        if let networkController = segue.destination as? NetworkController {
            networkController.inputLabel = changeLabel
            networkCont