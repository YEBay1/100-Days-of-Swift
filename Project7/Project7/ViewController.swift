//
//  ViewController.swift
//  Project7
//
//  Created by Yunus Emre Bayezit on 28.07.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var noFilter=[Petition]()
    var filterPetitions=[Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(sourceWay))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))

        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            //petitions = jsonPetitions.results
            filterPetitions=jsonPetitions.results
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return petitions.count
        return filterPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let petition = petitions[indexPath.row]
        let filterPetitions=filterPetitions[indexPath.row]
        //cell.textLabel?.text = petition.title
        //cell.detailTextLabel?.text = petition.body
        cell.textLabel?.text = filterPetitions.title
        cell.detailTextLabel?.text = filterPetitions.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        //vc.detailItem = petitions[indexPath.row]
        vc.detailItem = filterPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func sourceWay(){
        let ac = UIAlertController(title: "Warning!", message: "Data Comes from the White House's We The People API", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filter(){
        let ac = UIAlertController(title: "Enter Keyword", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Filter", style: .default) { [unowned self, ac] action in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
            
        }
        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    func submit(answer: String){
/*
    Dilekçe başlığının veya gövde metninin kullanıcının arama dizesini içerip içermediğini kontrol etmek için contains() kullanmaktır.
 
    Dilekçe dizinizdeki tüm öğeleri gözden geçirin ve istediklerinizi filtrelenmiş dilekçeye ekleyin.
*/
        
    }
    
    
}
