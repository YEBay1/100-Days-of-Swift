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

        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }

        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            filterPetitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }

        else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
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
    
    @objc func showError() {
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
        
    }
    
    
}
