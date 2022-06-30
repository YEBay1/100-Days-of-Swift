//
//  ViewController.swift
//  NotHesaplayıcı
//
//  Created by Yunus Emre Bayezit on 30.06.2022.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var titletxt: UILabel!
    
    @IBOutlet weak var midtermText: UITextField!
    
    @IBOutlet weak var finaltxt: UITextField!
    
    @IBOutlet weak var notelbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notelbl.text=""
        
        
    }

    @IBAction func calculatenote(_ sender: Any) {
        
        let midterm=Int(midtermText.text!)!
        
        let final=Int(finaltxt.text!)!
        
        let note=(midterm+final)/2
        
        notelbl.text="\(note)"
    }
    
}




