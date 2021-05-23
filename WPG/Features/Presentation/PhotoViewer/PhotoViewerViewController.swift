//
//  PhotoViewerViewController.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import UIKit

class PhotoViewerViewController: UIViewController {
    
    var photo: PhotoProtocol?
    var imagePreLoaded: UIImage?
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var viewer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        guard let image = imagePreLoaded else { return }
        viewer.image = image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let user = self.photo?.getUser() {
            (segue.destination as? UserDetailsTableViewController)?.user = user
        }
    }
}
