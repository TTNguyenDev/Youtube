//
//  MenuCell.swift
//  Youtube
//
//  Created by TT Nguyen on 10/3/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .gray
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.red : UIColor.gray
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        addSubview(imageView)
        
        addConstraintsWithForMat(format: "H:[v0(30)]", views: imageView)
        addConstraintsWithForMat(format: "V:[v0(30)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal
            , toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
