//
//  ViewController.swift
//  MyPhotoApp
//
//  Created by muhammad on 8/23/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var photoTableView: UITableView!
    
    var myPhotos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.photoTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotos()
        
    }
    
    func getPhotos() {
        
        let endpoint = "http://jsonplaceholder.typicode.com/photos"
        
        guard let url = URL(string: endpoint) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            if let error = err {
                print("There's a problem: \(error.localizedDescription)")
                
                return
            }
            if let data = dat {
                
                do {
                    self.myPhotos = try JSONDecoder().decode([Photo].self, from: data)
                    
                }
                    
                catch {
                    
                    print("There's a problem: \(error.localizedDescription)")
                }

            }
        }.resume()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
        let photo = myPhotos[indexPath.row]
        
        cell.photoTitleLabel.text = photo.title
        cell.photoIDLabel.text = "\(photo.id)"
        cell.photoImageView.downloaded(from: photo.thumbnailUrl)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let photo = myPhotos[indexPath.row]
        
        let imageVC = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        imageVC.thumbnailUrl = photo.thumbnailUrl
        self.navigationController?.pushViewController(imageVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    
        }
    
}
