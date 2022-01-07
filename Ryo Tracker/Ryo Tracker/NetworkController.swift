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
        super.viewDid