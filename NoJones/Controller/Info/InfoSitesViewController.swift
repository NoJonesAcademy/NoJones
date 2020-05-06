//
//  InfoSitesViewController.swift
//  NoJones
//
//  Created by Mateus Nobre Ferreira on 06/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit
import WebKit

class InfoSitesViewController: UIViewController, WKNavigationDelegate {
    
    var siteUrl:String?
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: siteUrl!)!
        webView.load(URLRequest(url: url))
        
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
