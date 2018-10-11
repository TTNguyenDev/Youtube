//
//  BaseCell.swift
//  Youtube
//
//  Created by TT Nguyen on 10/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
