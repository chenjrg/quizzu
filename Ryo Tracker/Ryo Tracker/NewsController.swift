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
     