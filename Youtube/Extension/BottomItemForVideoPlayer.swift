//
//  BottomItemForVideoPlayer.swift
//  Youtube
//
//  Created by TT Nguyen on 10/14/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class BottomItemForVideoPlayer: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    func fetchVideo() {
        ApiService.sharedInstance.fetchVideosForFeedCell { (videos: [Video]) in
            self.TitleName.text = videos[copyOfIndexPath].title
            self.numberOfViews.text = "Views: \(videos[copyOfIndexPath].number_of_views)"
            self.channelName.text = videos[copyOfIndexPath].channel.name
            let profileImageUrl = videos[copyOfIndexPath].channel.profile_image_name
            self.profileImage.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let TitleName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 25
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image 
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let numberOfViews: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let channelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        label.text = "Taylor Swift"
        return label
    }()
    
    let lineSpacing: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .gray
        return line
    }()
    
    let Upnext: UILabel = {
        let label = UILabel()
        label.text = "Up next"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        addSubview(TitleName)
        addSubview(profileImage)
        addSubview(numberOfViews)
        addSubview(Upnext)
        //        addSubview(cancelButton)
        addSubview(channelName)
        addSubview(lineSpacing)
        addSubview(collectionView)
        
        addConstraintsWithForMat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithForMat(format: "H:|-13-[v0]|", views: TitleName)
        addConstraintsWithForMat(format: "H:|-10-[v0]|", views: Upnext)
        addConstraintsWithForMat(format: "H:|-15-[v0]|", views: numberOfViews)
        addConstraintsWithForMat(format: "H:|-10-[v0(50)]-10-[v1]|", views: profileImage, channelName)
        addConstraintsWithForMat(format: "V:|-63-[v0]", views: channelName)
        addConstraintsWithForMat(format: "H:|[v0]|", views: lineSpacing)
        addConstraintsWithForMat(format: "V:|[v0(20)]-5-[v1]-10-[v2(50)]-15-[v3(1)]-10-[v4]-5-[v5]|", views: TitleName, numberOfViews, profileImage, lineSpacing, Upnext, collectionView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        collectionView.register(CollectionVideos.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchVideo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionVideos
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 1000)
    }
    
    
}
