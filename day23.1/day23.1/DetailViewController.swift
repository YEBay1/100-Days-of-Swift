//
//  DetailViewController.swift
//  day23.1
//
//  Created by Yunus Emre Bayezit on 11.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    var link : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage
        link = selectedImage
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped(){
        let vc=UIActivityViewController(activityItems:[link],applicationActivities:[])
        vc.popoverPresentationController?.barButtonItem=navigationItem.rightBarButtonItem
        present(vc,animated:true)
    }

}
