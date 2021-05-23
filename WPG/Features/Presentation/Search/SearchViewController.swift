//
//  SearchViewController.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import UIKit


class SearchViewController: UICollectionViewController {
    
    var photoList: [PhotoProtocol] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var indexSelected: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.setupUI(with: photoList[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = self.photoList[indexPath.row]
        
        let photoVC = UIStoryboard(name: "PhotoViewer", bundle: nil).instantiateViewController(identifier: "PhotoViewerViewController") as PhotoViewerViewController
        let cell = self.collectionView.cellForItem(at: indexPath) as! PhotoCell
        photoVC.imagePreLoaded = cell.photoImage.image
        photoVC.photo = photo
        
        self.present(photoVC, animated: true, completion: nil)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
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
