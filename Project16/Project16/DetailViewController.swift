//  DetailViewController.swift
//  Project4
//
//  Created by Yunus Emre Bayezit on 12.07.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController,WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["wikipedia.org"]
    var selectedSite : String = ""
    
    
    override func loadView() {
        webView=WKWebView()
        webView.navigationDelegate = self
        view=webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url=URL(string:"https://" + websites[0] + "/wiki/" + selectedSite)!
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer=UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:nil, action:nil)
        let refresh=UIBarButtonItem(barButtonSystemItem: .refresh, target:webView, action:#selector(webView.reload))
        
        let goBack=UIBarButtonItem(barButtonSystemItem: .done ,target: webView,action:#selector(webView.goBack))
        let goForward=UIBarButtonItem(barButtonSystemItem: .fastForward,target: webView,action:#selector(webView.goForward))

        toolbarItems = [progressButton, spacer, refresh,goBack,goForward]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),options: .new,context: nil)
        }
    
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            title = webView.title
        }
    
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "estimatedProgress" {
                progressView.progress = Float(webView.estimatedProgress)
            }
        }
    
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            let url = navigationAction.request.url

            if let host = url?.host {
                for website in websites {
                    if host.contains(website) {
                        decisionHandler(.allow)
                        return
                    }
                }
            }

            decisionHandler(.cancel)
        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.hidesBarsOnTap = true
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.hidesBarsOnTap = false
        }
}

