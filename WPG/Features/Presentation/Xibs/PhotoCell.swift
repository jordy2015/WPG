//
//  PhotoCell.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import UIKit
import AlamofireImage

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var photoImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(with photo: PhotoProtocol) {
        let user = photo.getUser()
        
        photoImage.image = nil
        profileImage.image = nil
        likesLabel.text = "\(photo.getLikes())"
        userNameLabel.text = user.getUserName()
        
        if let photoDataImage = photo.getImage() {
            
            photoImage.image = UIImage(data: photoDataImage)
            
            if let profileDataImage = user.getProfileImage() {
                profileImage.image = UIImage(data: profileDataImage)
            } else {
                profileImage.image = UIImage(named: "placeholder")
            }
        } else {
            if let photoUrl = URL(string: photo.getImageUrl()) {
                if let image = ImagesCache.default.getPhoto(key: photo.getId())?.getImage {
                    photoImage.image = image
                } else {
                    photoImage.af.setImage(withURL: photoUrl, cacheKey: photo.getId(), placeholderImage: UIImage(named: "placeholder"), completion:  { (image) in
                        ImagesCache.default.set(key: photo.getId(), photo: image.data)
                    })
                }
            } else {
                photoImage.image = UIImage(named: "placeholder")
            }
            
            if let userImageUrl = URL(string: user.getProfileImageUrl()) {
                if let image = ImagesCache.default.getprofileImage(key: user.getId())?.getImage {
                    profileImage.image = image
                } else {
                    profileImage.af.setImage(withURL: userImageUrl, cacheKey: user.getId(), placeholderImage: UIImage(named: "placeholder"), completion:  { (image) in
                        ImagesCache.default.set(key: user.getId(), profileImage: image.data)
                    })
                }
            } else {
                profileImage.image = UIImage(named: "placeholder")
            }
        }
    }
}
