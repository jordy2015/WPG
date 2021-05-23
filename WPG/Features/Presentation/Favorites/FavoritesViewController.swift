//
//  FavoritesViewController.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let presenter = FavoritesPresenter(useCase: DI.factory.getFavoritesUseCase())
    
    fileprivate var photoList: [PhotoProtocol] = [] {
        didSet {
            self.favoritesColletionView.reloadData()
        }
    }
    
    fileprivate var indexSelected: Int?

    let favoritesColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()
    
    let favoritesSearchController: UISearchController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let searchController = UISearchController(searchResultsController: SearchViewController(collectionViewLayout: layout))
        
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.attachView(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavorites()
    }
    
    deinit {
        presenter.detachView()
    }
    
    func setupUI() {
        self.view.addSubview(self.favoritesColletionView)
        navigationItem.searchController = favoritesSearchController
        
        self.favoritesColletionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.favoritesColletionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.favoritesColletionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.favoritesColletionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.favoritesColletionView.delegate = self
        self.favoritesColletionView.dataSource = self
        self.favoritesSearchController.searchResultsUpdater = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = self.indexSelected {
            let photo = self.photoList[index]
            (segue.destination as? PhotoViewerViewController)?.photo = photo
            
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.favoritesColletionView.cellForItem(at: indexPath) as! PhotoCell
            (segue.destination as? PhotoViewerViewController)?.imagePreLoaded = cell.photoImage.image
            segue.destination.presentationController?.delegate = self;
            self.indexSelected = nil
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
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
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
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

extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchResults = self.photoList
        
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        let filteredResults = searchResults.filter { $0.getUser().getUserName().contains(strippedString) || $0.getUser().getName().contains(strippedString)}
        
        if let searchViewController = searchController.searchResultsController as? SearchViewController {
            searchViewController.photoList = filteredResults
        }
    }
}

extension FavoritesViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        presenter.getFavorites()
    }
}

extension FavoritesViewController: FavoritesProtocol {
    func shouldDisplayActivityIndicator(_ shouldDisplay: Bool) {
        print(shouldDisplay)
    }
    
    func gotError(_ error: Error) {
        print("-> got ErrorXXXX")
        print(error)
    }
    
    func gotPhotos(photoList: [PhotoProtocol]) {
        self.photoList = photoList
    }
}
