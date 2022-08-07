//
//  ViewController.swift
//  Project8
//
//  Created by Yunus Emre Bayezit on 1.08.2022.
//

import UIKit

class ViewController: UIViewController {

    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var falseAnswer=0

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }

        loadLevel()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }

    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }

        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()

            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")

            currentAnswer.text = ""
            score += 1
        }
        else{
            let ac = UIAlertController(title: "Warning!", message: "Your answer is wrong", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Go", style: .default))
            present(ac, animated: true)
            
            score -= 1
            falseAnswer += 1
        }
        
        
        if score % 7-falseAnswer == 0 {
            let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
            present(ac, animated: true)
        }
    }

    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""

        for btn in activatedButtons {
            btn.isHidden = false
        }

        activatedButtons.removeAll()
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)

        loadLevel()

        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()

        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()

                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]

                    clueString += "\(index + 1). \(clue)\n"

                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)

                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }

        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

        letterBits.shuffle()

        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)

        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)

        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
            
            // ipucu etiketinin üst kısmını score etiketinin altına sabitleyin
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

            // ipucu etiketinin ön kenarını düzen kenar boşluklarımızın ön kenarına sabitleyin, biraz boşluk için 100 ekleyin
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),

            // ipucu etiketini düzen kenar boşluklarımızın genişliğinin %60'ı, eksi 100 yapın
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),

            // ayrıca cevaplar etiketinin üst kısmını puan etiketinin altına sabitleyin
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

            // cevaplar etiketinin düzen kenar boşluklarımızın son kenarına yapışmasını sağlayın, eksi 100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),

            // cevap etiketinin mevcut alanın %40'ını kaplamasını sağlayın, eksi 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),

            // cevaplar etiketini ipuçları etiketinin yüksekliğine uygun hale getirin
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),

            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        let width = 150
        let height = 80

        // 4x5 ızgara olarak 20 düğme oluşturun
        for row in 0..<4 {
            for col in 0..<5 {
                // yeni bir düğme oluşturun ve büyük bir yazı tipi boyutu verin
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)

                // ekranda görebilmemiz için düğmeye geçici bir metin verin
                letterButton.setTitle("WWW", for: .normal)

                // sütun ve satırını kullanarak bu düğmenin çerçevesini hesaplar
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor

                // düğmeler görünümüne ekleyin
                buttonsView.addSubview(letterButton)

                // ve ayrıca letterButtons dizimize
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
            }
        }
    }
    
    
    
}









