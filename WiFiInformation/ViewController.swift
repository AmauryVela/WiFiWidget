//
//  ViewController.swift
//  WiFiInformation
//
//  Created by Angel Amaury Vela Mireles on 1/23/19.
//  Copyright © 2019 aavm. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import SystemConfiguration

class ViewController: UIViewController {

    @IBOutlet weak var wifiSSIDLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSSID()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupSSID() {
        let networkStatus = Reachability.getNetworkStatus()
        switch  networkStatus {
        case .none:
            wifiSSIDLabel.text = "UNKNOWN"
        case .wifi:
            guard let wifiSSID = Reachability.getWiFiSSID()  else {
                wifiSSIDLabel.text = "UNKNOWN"
                return
            }
            wifiSSIDLabel.text = "\(wifiSSID)"
            iconImageView.image = #imageLiteral(resourceName: "WIFIIcon")
        case .wwan:
            wifiSSIDLabel.text = "Cellular"
            iconImageView.image = #imageLiteral(resourceName: "CellularIcon")
        }
    }
}

