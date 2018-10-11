import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "celId"
    let trendingCellId = "trendingCell"
    let subscriptionsCellId = "subscriptionsId"
    let titleName = ["Home", "Trending", "Subscriptions", "Account"]
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    @objc func handleSearch() {
        print("searchButton")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleName(index: 0)
        setupMenuBar()
        setupShadow()
        setupNavBarButton()
        setupCollectionView()
    }
    
    func setupTitleName(index: Int) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = " \(titleName[index])"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        navigationItem.titleView = titleLabel
    }
    
    
    func setupShadow() {
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.darkGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 10
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 10
    }
    
    func setupCollectionView() {
        if let flowlayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 0
        }
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellId)
        collectionView.isPagingEnabled = true
    }
    
    func showControllerForSetting(setting: Setting) {
        let settingsController = UIViewController()
        settingsController.view.backgroundColor = .white
        settingsController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setupTitleName(index: menuIndex)
    }
    
    func setupNavBarButton() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon"), style: .plain, target: self, action: #selector(handleMore))
        
        searchButton.tintColor = .gray
        moreButton.tintColor = .gray
        
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    lazy var setupItemForMenuBar: MenuBar = {
        let bar = MenuBar()
        bar.homeController = self
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
        view.addSubview(setupItemForMenuBar)
        
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: bottomView)
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: setupItemForMenuBar)
        view.addConstraintsWithForMat(format: "V:[v0(1)]-0-[v1(50)]-0-[v2(35)]", views:
            line, setupItemForMenuBar, bottomView)
        
        bottomView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setupItemForMenuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        setupItemForMenuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        setupTitleName(index: indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 1:
            return collectionView.dequeueReusableCell(withReuseIdentifier: trendingCellId, for: indexPath)
        case 2:
            return collectionView.dequeueReusableCell(withReuseIdentifier: subscriptionsCellId  , for: indexPath)
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 126)
    }
    
}



