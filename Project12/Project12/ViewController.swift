//
//  ViewController.swift
//  Project12
//
//  Created by Yunus Emre Bayezit on 29.08.2022.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        let array = ["Hello", "World"]
        let dict = ["Name": "Paul", "Country": "UK"]
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        defaults.set(array, forKey: "SavedArray")
        
        defaults.set(dict, forKey: "SavedDict")
        
        let array1 = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
        let dict1 = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()

    }


}

