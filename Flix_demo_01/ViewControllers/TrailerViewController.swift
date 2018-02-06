//
//  TrailerViewController.swift
//  Flix_demo_01
//
//  Created by Anish Adhikari on 1/31/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    
    var url = "https://www.dropbox.com/terms?mobile=1"
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationBar = navigationController?.navigationBar {
            
            navigationBar.tintColor = UIColor(red: 5, green: 1, blue: 1, alpha: 2)
        }
        
        
        let requestURL = URL(string:url)
        // Place the URL in a URL Request.
        let request = URLRequest(url: requestURL!)
        // Load Request into WebView.
        webView.load(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToDetails(_ sender: Any) {
        print("go back")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
