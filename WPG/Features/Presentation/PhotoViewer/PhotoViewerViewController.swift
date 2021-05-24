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
    @IBOutlet weak var favoriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let image = imagePreLoaded {
            viewer.image = image
        }
        
        if let p = photo, p.isFavorite(search: DI.factory.getDatabaseHandler()) {
            favoriteBtn.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteBtn.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let user = self.photo?.getUser() {
            (segue.destination as? UserDetailsTableViewController)?.user = user
        }
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        let database = DI.factory.getDatabaseHandler()
        let photoEntity = database.searchPhoto(with: photo?.getId() ?? "")
        if let entity = photoEntity {
            favoriteBtn.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            database.delete(entity)
            if let navBar = self.navigationController {
                navBar.popViewController(animated: true)
            }
        } else {
            favoriteBtn.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            photo?.save(in: DI.factory.getDatabaseHandler())
        }
    }
    
}
