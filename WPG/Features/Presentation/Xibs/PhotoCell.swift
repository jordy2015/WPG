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
        
        if photo.isFavorite() {
            if let photoDataImage = photo.getImage() {
                photoImage.image = UIImage(data: photoDataImage)
            } else {
                photoImage.image = UIImage(named: "placeholder")
            }
            
            if let profileDataImage = user.getProfileImage() {
                profileImage.image = UIImage(data: profileDataImage)
            } else {
                profileImage.image = UIImage(named: "placeholder")
            }
        } else {
            if let photoUrl = URL(string: photo.getImageUrl()) {
                photoImage.af.setImage(withURL: photoUrl, cacheKey: photo.getId(), placeholderImage: UIImage(named: "placeholder"))
                photoImage.af.setImage(withURL: photoUrl, placeholderImage: UIImage(named: "placeholder"))
            } else {
                photoImage.image = UIImage(named: "placeholder")
            }
            
            if let userImageUrl = URL(string: user.getProfileImageUrl()) {
                profileImage.af.setImage(withURL: userImageUrl, cacheKey: user.getId(), placeholderImage: UIImage(named: "placeholder"))
            } else {
                profileImage.image = UIImage(named: "placeholder")
            }
        }
    }

}
