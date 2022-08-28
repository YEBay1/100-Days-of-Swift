//
//  DetailViewController.swift
//  Project7
//
//  Created by Yunus Emre Bayezit on 30.07.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    // Storyboard'da bir Detail View Controller yok.
    // ViewController'ın alt sınıfı olarak tanımladık ve başarı ile nesnelerin üzerine tıkladığımızda sonraki sayfaya aktarılabiliyoruz.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
        body { font-size: 150%;}
        body { background-color: yellow;}
        </style>
        </head>
        <body style="color:blue;">
        \(detailItem.body)
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
}
