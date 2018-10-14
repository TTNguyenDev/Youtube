import UIKit

class VideoPlayer: NSObject {
    var view = UIView(frame: CGRect(x: 0, y:0, width: 0, height: 0))
    func showSettings() {
        if let keyWindow = UIApplication.shared.keyWindow {
            view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            let itemFrame = CGRect(x: 0, y: 220, width: keyWindow.frame.width, height: 800)
            let item = BottomItemForVideoPlayer(frame: itemFrame)
            
            view.addSubview(item)

            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.frame = keyWindow.frame
            }) { (completedAnimation) in
            }
        }
    }
}
