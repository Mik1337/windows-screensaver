//
//  windowsView.swift
//  windows-screensaver
//
//  Created by Mik
//  Codespiration https://github.com/zzzDavid/bubble-screensaver
//  Windows Screen Saver https://media.giphy.com/media/WglYvrK09UbNCuYSuH/source.gif
//  thumbnail https://www.nicepng.com/maxp/u2q8w7a9e6r5r5i1/

import ScreenSaver
import AVFoundation
import AVKit

class windowsScreenSaver: ScreenSaverView {
    
    var playerLooper: AVPlayerLooper!
    var queuePlayer: AVQueuePlayer!
    var playerLayer:AVPlayerLayer!
    var videoView: NSView!

    // MARK: - Initialization
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        guard let windowsSaver = Bundle(for: type(of: self)).path(forResource: "windows-screensaver", ofType: "mp4") else {
                fatalError("path to windows screen saver not found")
            }

        let fileURL = URL(fileURLWithPath: windowsSaver)
        let asset = AVAsset(url: fileURL)
        let playerItem = AVPlayerItem(asset: asset)
        
        self.queuePlayer = AVQueuePlayer(items: [playerItem])
        self.playerLooper = AVPlayerLooper(player: self.queuePlayer, templateItem: playerItem)
        self.playerLayer = AVPlayerLayer(player: self.queuePlayer)
        
        self.videoView = NSView(frame: NSScreen.main?.frame ?? NSMakeRect(0, 0, 1680, 1050))
        self.videoView.wantsLayer = true
        self.playerLayer.frame = videoView.frame
        self.videoView.layer = self.playerLayer
        
        self.addSubview(self.videoView)
            
        // note: when you turn the subview's translateAutoresizingMaskIntoConstriants option off,
        // you have to specify a whole set of layout constraint for the subview.
        // also, don't turn superview's switch off.

        videoView.translatesAutoresizingMaskIntoConstraints = false
        self.videoView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.videoView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.videoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        self.videoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
    }
    
    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func draw(_ rect: NSRect) {
        self.queuePlayer.play()
    }
    
    override func animateOneFrame() {
        super.animateOneFrame()
        setNeedsDisplay(bounds)
    }
    
}
