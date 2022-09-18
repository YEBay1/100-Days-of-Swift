//
//  ViewController.swift
//  Project1
//
//  Created by Yunus Emre Bayezit on 5.07.2022.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var pictures = [Person]()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Pictures"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
	}
    
    func imagePickerController(_ picker: UIImagePickerController , didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        let person = Person(name: "Unknown", image: imageName)
        
        pictures.append(person)
        
        self.save()
        
        tableView?.reloadData()

        dismiss(animated: true)
    }


	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pictures.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath)

        cell.textLabel?.text = pictures[indexPath.item].image

        let path = getDocumentsDirectory().appendingPathComponent(pictures[indexPath.item].image)
        cell.imageView?.image = UIImage(contentsOfFile: path.path)

        self.save()
        return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].image
			navigationController?.pushViewController(vc, animated: true)
            self.save()
		}
    }
    
    @objc func addNewPerson(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        //picker.sourceType = .camera
        
        self.save()
        present(picker, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func save(){
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictures){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "pictures")
        } else{
            print("Failed to save people")
        }
    }
}


