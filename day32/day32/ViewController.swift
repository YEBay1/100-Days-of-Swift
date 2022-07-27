//
//  ViewController.swift
//  day32
//
//  Created by Yunus Emre Bayezit on 27.07.2022.
//

import UIKit

class ViewController: UITableViewController {
    var urunler=["salata","elma","havuç","ekmek"]
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Temizle", style: .plain, target: self, action: #selector(clearAll))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    @objc func clearAll(){
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func addList(){
        let ac=UIAlertController(title: "Ürün Giriniz", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Kaydet", style: .default) { [unowned self, ac] action in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        
        for urun in urunler{
            if lowerAnswer==urun{
                usedWords.insert(answer, at: 0)

                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
            else{
                
                }
            }
        }
    }

