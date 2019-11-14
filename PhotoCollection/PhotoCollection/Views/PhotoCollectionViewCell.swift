//
//  PhotoCollectionViewCell.swift
//  PhotoCollection
//
//  Created by Spencer Curtis on 8/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    private var photoSelected: UIImageView!
    private var nameLabel: UILabel!

    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpSubviews()
    }
    
    func setUpSubviews() {
        let photoView = UIImageView()
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.contentMode = .scaleAspectFit
        addSubview(photoView)
        
        NSLayoutConstraint(item: photoView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 4).isActive = true
        
        NSLayoutConstraint(item: photoView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 4).isActive = true
        
        NSLayoutConstraint(item: photoView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -4).isActive = true
        
        NSLayoutConstraint(item: photoView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: photoView,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        self.photoSelected = photoView
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        
        NSLayoutConstraint(item: nameLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: photoView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 4).isActive = true
        
        NSLayoutConstraint(item: nameLabel,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 2).isActive = true
        
        NSLayoutConstraint(item: nameLabel,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -2).isActive = true
        
        self.nameLabel = nameLabel
        
    }
    
    private func updateViews() {
        guard let photo = photo else { fatalError("A photo image was not loaded in the cell.")}
        photoSelected.image = UIImage(data: photo.imageData)
        nameLabel.text = photo.title
    }
    
}
