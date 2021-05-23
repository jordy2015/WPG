//
//  GalleryViewController.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import UIKit

class GalleryViewController: UIViewController {
    
    private let presenter = GalleryPresenter(repository: DI.factory.getGalleryRepository())
    
    fileprivate var photoList: [PhotoProtocol] = [] {
        didSet {
            self.galleryColletionView.reloadData()
        }
    }
    
    fileprivate var photoSelected: PhotoProtocol?

    private let galleryColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()
    
    private let gallerySearchController: UISearchController = {
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
    
    private func setupUI() {
        self.view.addSubview(self.galleryColletionView)
        navigationItem.searchController = gallerySearchController
        
        self.galleryColletionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.galleryColletionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.galleryColletionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.galleryColletionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.galleryColletionView.delegate = self
        self.galleryColletionView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photo = self.photoSelected {
            (segue.destination as? PhotoViewerViewController)?.photo = photo
            self.photoSelected = nil
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.setupUI(with: photoList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photoList[indexPath.row]
        self.photoSelected = photo
        performSegue(withIdentifier: "PhotoViewerSegue", sender: nil)
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = self.photoList[indexPath.row]
        let porcentage: Float = Float(photo.getHeight())/Float(photo.getWidth())/2
        let height = porcentage > Float(0.8) ? collectionView.bounds.height * 0.8 : collectionView.bounds.height * CGFloat(porcentage)
        return CGSize(width: collectionView.bounds.width, height: height)
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
    
    func gotPhotos(photoList: [PhotoProtocol]) {
        self.photoList.append(contentsOf: photoList)
    }
}
