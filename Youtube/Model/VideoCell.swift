import UIKit

class VideoCell: UICollectionViewCell {
    
    let thumbnailIamge: CustomImageView = {
        let image = CustomImageView()
        image.image = UIImage(named: "taylor_swift_bad_blood")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let userProfileImageView: CustomImageView = {
        let image = CustomImageView()
        image.image = UIImage(named: "kanye_profile")
        image.layer.cornerRadius = 22
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.text = "Hello - Taylor Swift"
        title.font = .systemFont(ofSize: 18)
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.text = "bdhagfhsfjskfklsfnajkfh"
        title.font = .systemFont(ofSize: 14)
        title.textColor = UIColor.darkGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let spacing: UIView = {
        let spacing = UIView()
        spacing.backgroundColor = .lightGray
        spacing.translatesAutoresizingMaskIntoConstraints = false
        return spacing
    }()
    
    var video: Video? {
        didSet {
            title.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) •  2 years ago"
                subTitle.text = subtitleText
            }
            
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 17, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedString.Key: UIFont.systemFont(ofSize: 14)], context: nil)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailIamge.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    func setupView() {
        addSubview(thumbnailIamge)
        addSubview(userProfileImageView)
        addSubview(title)
        addSubview(subTitle)
        addSubview(spacing)
        
        addConstraintsWithForMat(format: "H:|-16-[v0]-16-|", views: thumbnailIamge)
        addConstraintsWithForMat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithForMat(format: "H:|[v0]|", views: spacing)
        addConstraintsWithForMat(format: "V:|-8-[v0]-8-[v1(44)]-16-[v2(1)]-8-|", views: thumbnailIamge, userProfileImageView, spacing)
        
        addConstraint(NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: thumbnailIamge, attribute: .bottom, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: title, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: title, attribute: .right, relatedBy: .equal, toItem: thumbnailIamge, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: title, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .top, relatedBy: .equal, toItem: title, attribute: .bottom, multiplier: 1, constant: 2))
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .right, relatedBy: .equal, toItem: thumbnailIamge, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
