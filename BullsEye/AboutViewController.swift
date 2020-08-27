//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Andrew Maher on 8/26/20.
//  Copyright © 2020 Andrew Maher. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let url = Bundle.main.url(forResource: "index", withExtension: "html"){
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        /* let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html")!
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
        */
        /*let htmlPath = Bundle.main.path(forResource: "BullsEye", ofType: "html")
        print(htmlPath!)
        let url = URL(fileURLWithPath: htmlPath!)
        let request = URLRequest(url: url)
        webView.load(request)*/
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



