//
//  RecommendVideos.swift
//  Youtube
//
//  Created by TT Nguyen on 10/14/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class RecommendVideos: BaseCell {

    let thumbnailIamge: CustomImageView = {
        let image = CustomImageView()
        image.image = UIImage(named: "taylor_swift_bad_blood")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 15)
        title.textColor = .black
        title.numberOfLines = 3
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
    
    var video: Video? {
        didSet {
            title.text = video?.title
            setupThumbnailImage()
            subTitle.text = "\((video?.channel.name)!) - \((video?.number_of_views)!)"
           
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            thumbnailIamge.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    override func setupView() {
        addSubview(thumbnailIamge)
        addSubview(title)
        addSubview(subTitle)
        
        addConstraintsWithForMat(format: "H:|-10-[v0(170)]-8-[v1]|", views: thumbnailIamge, title)
        addConstraintsWithForMat(format: "V:|-10-[v0]-10-|", views: thumbnailIamge)
        addConstraintsWithForMat(format: "V:|-10-[v0]", views: title)
        
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
        subTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        subTitle.leftAnchor.constraint(equalTo: thumbnailIamge.rightAnchor, constant: 8).isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
}

class CollectionVideos:  BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var videos: [Video]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupView() {
        super.setupView()
        fetchVideo()
        addSubview(collectionView)
        
        addConstraintsWithForMat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithForMat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(RecommendVideos.self, forCellWithReuseIdentifier: cellId)
    }
    
    func fetchVideo() {
        ApiService.sharedInstance.fetchVideosForFeedCell { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecommendVideos
        cell.video = videos?[indexPath.item]
        copyOfIndexPath = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoPlayer = VideoPlayer()
        videoPlayer.showSettings()
        copyOfIndexPath = indexPath.row
    }
    
}
