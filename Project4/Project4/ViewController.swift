//
//  ViewController.swift
//  Project4
//
//  Created by Yunus Emre Bayezit on 10.07.2022.
//

import UIKit

class ViewController: UITableViewController {
    var websites = ["apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedSite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
