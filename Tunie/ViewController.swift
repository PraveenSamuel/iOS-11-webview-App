//
//  ViewController.swift
//  Tunie
//
//  Created by Praveen Samuel . J on 21/09/17.
//  Copyright © 2017 Praveen Samuel . J. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    @IBOutlet weak var UIweb: UIWebView!
    
    @IBAction func back(_ sender: Any) {
        if UIweb.canGoBack{
            UIweb.goBack()
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if UIweb.canGoForward{
            UIweb.goForward()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        UIweb.reload()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://www.smartshoppi.com/")
        UIweb.loadRequest(URLRequest(url: url!))
    }
    override func viewDidAppear(_ animated: Bool) {
        if isInternetAvailable() {
            // internet there
        }else{
            let alert = UIAlertController(title: "No Internet Connection" , message: "Please Turn on your mobile data or Wifi", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(action)
            
            alert.view.tintColor = UIColor.red
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }


}

