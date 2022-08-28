//
//  ViewController.swift
//  Project1
//
//  Created by Yunus Emre Bayezit on 5.07.2022.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	var pictures = [String]()
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    @IBOutlet var imageName: UILabel!
    
    var link="https://github.com/YEBay1/IOS/tree/main/Project1"
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        title = selectedImage
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = self.selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }

		title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
        DispatchQueue.global(qos: .userInitiated).async {
			if item.hasPrefix("nssl") {
                self.pictures.append(item)
                self.pictures.sort()
			}
		}
	}
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
        
}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath)
		//cell.textLabel?.text = pictures[indexPath.row]
        let imageName = pictures[indexPath.item]
        
		return cell
	}
    
/*
	override func collectionView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "View") as? ViewController {
			vc.selectedImage = pictures[indexPath.row]
			navigationController?.pushViewController(vc, animated: true)
        }
	}*/

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
