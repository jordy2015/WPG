//
//  GalleryViewController.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import UIKit

class GalleryViewController: UIViewController {
    
    let presenter = GalleryPresenter(repository: DI.factory.getGalleryRepository())

    let galleryColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        return collectionView
    }()
    
    let gallerySearchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.attachView(self)
        presenter.getPhotos(page: 1)
    }
    
    deinit {
        presenter.detachView()
    }
    
    func setupUI() {
        self.view.addSubview(self.galleryColletionView)
        navigationItem.searchController = gallerySearchController
        
        self.galleryColletionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.galleryColletionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.galleryColletionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.galleryColletionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.galleryColletionView.delegate = self
        self.galleryColletionView.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 15
        return CGSize(width: width, height: width + 80)
    }
}

extension GalleryViewController: GalleryProtocol {
    func shouldDisplayActivityIndicator(_ shouldDisplay: Bool) {
        print(shouldDisplay)
    }
    
    func gotError(_ error: Error) {
        print("-> got ErrorXXXX")
        print(error)
    }
    
    func gotPhotos(photosList: [PhotoProtocol]) {
        print("-> got data!!!")
        print(photosList)
    }
}
