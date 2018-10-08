//
//  ViewController.swift
//  Youtube
//
//  Created by TT Nguyen on 10/2/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "celId"
    var videos: [Video]?
    
    func fetchVideo() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["channel"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self.videos?.append(video)
                }
                DispatchQueue.main.async(execute: {
                    self.collectionView.reloadData()
                })
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideo()
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 10
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 10
        
        titleLabel.text = "  YouTube"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = titleLabel
        
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        setupMenuBar()
        setupNavBarButton()
        
    }
    
    func showControllerForSetting(setting: Setting) {
        let settingsController = UIViewController()
        settingsController.view.backgroundColor = .white
        settingsController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    func setupNavBarButton() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon"), style: .plain, target: self, action: #selector(handleMore))
        
        searchButton.tintColor = .gray
        moreButton.tintColor = .gray

        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    let settingsLauncher = SettingsLauncher()
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    @objc func handleSearch() {
        print("searchButton")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    let setupItemForMenuBar: MenuBar = {
        let bar = MenuBar()
        return bar
    }()
    
    func setupMenuBar() {
        
        let line = UIView()
        line.backgroundColor = .gray
        view.addSubview(line)
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: line)
    
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: bottomView)
       
        
      
        view.addSubview(setupItemForMenuBar)
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: setupItemForMenuBar)
        view.addConstraintsWithForMat(format: "V:[v0(1)]-0-[v1(50)]-0-[v2(35)]", views:
            line, setupItemForMenuBar, bottomView)
        
        bottomView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
    }
}



