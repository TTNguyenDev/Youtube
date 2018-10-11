import UIKit

class MenuCell: BaseCell {
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .gray
        return image
    }()
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.red : UIColor.gray
        }
    }

    override func setupView() {
        addSubview(imageView)
        
        addConstraintsWithForMat(format: "H:[v0(30)]", views: imageView)
        addConstraintsWithForMat(format: "V:[v0(30)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal
            , toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
