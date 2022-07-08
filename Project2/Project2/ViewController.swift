//
//  ViewController.swift
//  Project2
//
//  Created by Yunus Emre Bayezit on 6.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var label: UILabel!
    
    var countries=[String]()
    var correctAnswer=0
    var score=0
    var answer=0
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth=12
        button2.layer.borderWidth=12
        button3.layer.borderWidth=12
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion(action:nil)
    }
    
    func askQuestion(action: UIAlertAction!){
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]),for: .normal)
        button2.setImage(UIImage(named: countries[1]),for: .normal)
        button3.setImage(UIImage(named: countries[2]),for: .normal)
        
        correctAnswer=Int.random(in: 0...2)
        
        title=countries[correctAnswer].uppercased() 
        
        //label.text="Score: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag==correctAnswer{
            title="Correct"
            score += 1
            answer += 1
        }

        else{
            title="Wrong"
            score -= 1
            answer += 1
        }
        
    
        if answer == 10{
            let ac = UIAlertController(title: "Number of questions asked:\(answer)", message: "Your last score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }

        
        
        if sender.tag != correctAnswer{
            let ac = UIAlertController(title: title, message: "Correct answer is \(countries[sender.tag].uppercased()).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        else{
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
    }
    
    @objc func shareTapped(){
        let vc=UIActivityViewController(activityItems:["Your score: \(score)"],applicationActivities:[])
        vc.popoverPresentationController?.barButtonItem=navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
