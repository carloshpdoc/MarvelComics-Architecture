//
//  ComicsViewController.swift
//  MarvelMVCExample
//
//  Created by carloshenrique.carmo on 26/04/19.
//  Copyright © 2019 carloshpdoc. All rights reserved.
//

import UIKit
import WebKit

class ComicsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var comics: Comics!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = comics.urls.first?.url {
            let req = URL(string: url)
            let request = URLRequest(url: req!)

            webView.allowsBackForwardNavigationGestures = true
            webView.navigationDelegate = self
            webView.load(request)
        }
        title = comics.title
    }
}

extension ComicsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
