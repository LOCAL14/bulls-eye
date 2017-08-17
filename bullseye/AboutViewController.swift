//
//  AboutViewController.swift
//  bullseye
//
//  Created by 夏震 on 2017/7/11.
//  Copyright © 2017年 夏震. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html",textEncodingName:  "UTF-8",baseURL: baseURL)
            }
        }
    }
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var webView: UIWebView!
}
