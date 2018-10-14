import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    var player: AVPlayer?
    var isPlaying = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView()
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(sliderVideo)
        controlsContainerView.addSubview(lengthOfVideo)
        controlsContainerView.addSubview(currentTimeVideoPlaying)
        controlsContainerView.addSubview(activityIndicatorView)
        controlsContainerView.addSubview(PlayPauseButton)
        
        controlsContainerView.frame = frame
        
        PlayPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        PlayPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        PlayPauseButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        PlayPauseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        sliderVideo.leftAnchor.constraint(equalTo: currentTimeVideoPlaying.rightAnchor).isActive = true
        sliderVideo.rightAnchor.constraint(equalTo: lengthOfVideo.leftAnchor).isActive = true
        sliderVideo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sliderVideo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        lengthOfVideo.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        lengthOfVideo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        lengthOfVideo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lengthOfVideo.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        currentTimeVideoPlaying.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        currentTimeVideoPlaying.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeVideoPlaying.heightAnchor.constraint(equalToConstant: 20).isActive = true
        currentTimeVideoPlaying.widthAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    func setupSlider() {
        
        let duration = CMTimeGetSeconds((player?.currentItem?.duration)!)
        let secondsString = String(format: "%02d", Int(duration.truncatingRemainder(dividingBy: 60)))
        let minutesString = String(format: "%02d", Int(duration / 60))
        self.lengthOfVideo.text = "\(minutesString):\(secondsString)"
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
            let seconds = CMTimeGetSeconds((self.player?.currentTime())!)
            let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
            let minutesString = String(format: "%02d", Int(seconds / 60))
            self.currentTimeVideoPlaying.text = "\(minutesString):\(secondsString)"
            
            self.sliderVideo.value = Float(seconds/duration)
        }
    }
    
    let lengthOfVideo: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeVideoPlaying: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    let sliderVideo: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
                print(sliderVideo.value)
                guard let duration = player?.currentItem?.duration else { return }
                let totalSeconds = CMTimeGetSeconds(duration)
                let value = Float64(sliderVideo.value) * totalSeconds
                let seekTime = CMTime(value: Int64(value), timescale: 1)
        
                player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                    //add something later
                })
    }
    
    
    lazy var PlayPauseButton: UIButton = {
        let button = UIButton()
        let imageChange = UIImage(named: "pause")
        button.setImage(imageChange, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePlayPause() {
        if isPlaying {
            player?.pause()
            PlayPauseButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            PlayPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    private func setupPlayerView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        if let url = NSURL(string: urlString) {
            player = AVPlayer(url: url as URL)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            isPlaying = true
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            PlayPauseButton.isHidden = false
            setupSlider()
            
        }
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

