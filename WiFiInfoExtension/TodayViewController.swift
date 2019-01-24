//
//  TodayViewController.swift
//  WiFiInfoExtension
//
//  Created by Angel Amaury Vela Mireles on 1/23/19.
//  Copyright © 2019 aavm. All rights reserved.
//

import UIKit
import NotificationCenter
import SystemConfiguration.CaptiveNetwork

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var wifiSSIDLabel: UILabel!
    
    @IBOutlet weak var iconImageview: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.extensionContext?.widgetLargestAvailableDisplayMode = .compact
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        setupSSID()
        completionHandler(NCUpdateResult.newData)
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
            iconImageview.image = #imageLiteral(resourceName: "WIFIIcon")
        case .wwan:
            wifiSSIDLabel.text = "Cellular"
            iconImageview.image = #imageLiteral(resourceName: "CellularIcon")
        }
    }
    
    @IBAction func openSettingsApp(_ sender: Any) {
        if let settings = URL(string: "speedtest://") {
            self.extensionContext?.open(settings)
        }
    }

}
