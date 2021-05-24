//
//  GalleryViewController.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import UIKit

class GalleryViewController: UIViewController {
    
    private let presenter = GalleryPresenter(useCase: DI.factory.getPhotosUseCase())
    
    fileprivate var photoList: [PhotoProtocol] = [] {
        didSet {
            self.galleryColletionView.reloadData()
        }
    }
    
    fileprivate var indexSelected: Int?
    fileprivate var page: Int = 1
    fileprivate var isLocalMode: Bool = false

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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let searchController = UISearchController(searchResultsController: SearchViewController(collectionViewLayout: layout))
        
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private let loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.attachView(self)
        presenter.getPhotos(page: self.page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLocalMode {
            presenter.getPhotos(page: self.page)
        }
    }
    
    deinit {
        presenter.detachView()
    }
    
    private func setupUI() {
        self.view.addSubview(self.galleryColletionView)
        self.view.addSubview(self.loader)
        navigationItem.searchController = gallerySearchController
        
        self.galleryColletionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.galleryColletionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.galleryColletionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.galleryColletionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.galleryColletionView.delegate = self
        self.galleryColletionView.dataSource = self
        self.gallerySearchController.searchResultsUpdater = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = self.indexSelected {
            let photo = self.photoList[index]
            (segue.destination as? PhotoViewerViewController)?.photo = photo
            
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.galleryColletionView.cellForItem(at: indexPath) as! PhotoCell
            (segue.destination as? PhotoViewerViewController)?.imagePreLoaded = cell.photoImage.image
            
            self.indexSelected = nil
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
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
        self.indexSelected = indexPath.row
        performSegue(withIdentifier: "PhotoViewerSegue", sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height && !isLocalMode {
            presenter.getPhotos(page: self.page)
        }
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

extension GalleryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchResults = self.photoList
        
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        let filteredResults = searchResults.filter { $0.getUser().getUserName().contains(strippedString) || $0.getUser().getName().contains(strippedString)}
        
        if let searchViewController = searchController.searchResultsController as? SearchViewController {
            searchViewController.photoList = filteredResults
        }
    }
}

extension GalleryViewController: GalleryProtocol {
    func isLocal(_ flag: Bool) {
        self.isLocalMode = flag
    }
    
    func shouldDisplayActivityIndicator(_ shouldDisplay: Bool) {
        shouldDisplay ? self.loader.startAnimating() : self.loader.stopAnimating()
    }
    
    func gotError(_ error: Error) {
        self.showAlert(title: "Error!", message: error.localizedDescription)
    }
    
    func gotPhotos(photoList: [PhotoProtocol]) {
        if isLocalMode {
            self.photoList = photoList
        } else {
            self.page += 1
            self.photoList.append(contentsOf: photoList)
        }
    }
}
