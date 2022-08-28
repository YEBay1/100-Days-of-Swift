//
//  ViewController.swift
//  day41
//  Created by Yunus Emre Bayezit on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {
    let word="Selam"
    var answer=[String]()
    
    var score=0
    var rightAnswer=0
    var wrongAnswer=0
    
    @IBOutlet var answerText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func game(){
        
        var answer = answerText.text
        
    }
    
    @IBAction func submitTapped(sender: UIButton){
    
    }
}
