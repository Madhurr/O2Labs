//
//  PhotoDetailViewController.swift
//  MVVMPlayground
// Created by Madhur Jain on 29/02/2019

import UIKit
import SDWebImage

class PhotoDetailViewController: UIViewController {

    var imageUrl: String?
    var imageNameL: String?
    var imageDescription: String?
    var imageRating: Double = 0.0
    var userNamex: String?
    var userCamerax: String?
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userCamera: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var photoName: UILabel!
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var photoRating: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoName.text = imageNameL
        photoDescription.text = imageDescription
        photoRating.text = "Rating: \(imageRating)"
        userName.text = "Captured by: \(userNamex ?? "")"
        userCamera.text = "Camera: \(userCamerax ?? "")"
        if let imageUrl = imageUrl {
            imageView.sd_setImage(with: URL(string: imageUrl)) { (image, error, type, url) in
            
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
