import UIKit

class VideoCell: BaseCell {
    
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
        title.font = .systemFont(ofSize: 15)
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 12)
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
        
            if let channelName = video?.channel.name, let numberOfViews = video?.number_of_views {
        
                let subtitleText = "\(channelName) • \(numberOfViews) •  2 years ago"
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
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel.profile_image_name {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            thumbnailIamge.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    override func setupView() {
        addSubview(thumbnailIamge)
        addSubview(userProfileImageView)
        addSubview(title)
        addSubview(subTitle)
        addSubview(spacing)
        
        addConstraintsWithForMat(format: "H:|-8-[v0]-8-|", views: thumbnailIamge)
        addConstraintsWithForMat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithForMat(format: "H:|[v0]|", views: spacing)
        addConstraintsWithForMat(format: "V:|-10-[v0]-10-[v1(44)]-16-[v2(1)]-8-|", views: thumbnailIamge, userProfileImageView, spacing)
        
        addConstraint(NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: thumbnailIamge, attribute: .bottom, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: title, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: title, attribute: .right, relatedBy: .equal, toItem: thumbnailIamge, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: title, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .top, relatedBy: .equal, toItem: title, attribute: .bottom, multiplier: 1, constant: 2))
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .right, relatedBy: .equal, toItem: thumbnailIamge, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    }
}
