//
//  VideoLauncher.swift
//  Youtube
//
//  Created by NDS on 24/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    var isPlaying = true
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    let loadingPlayer: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        aiv.startAnimating()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handelPlayPause), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    let currentLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        return label
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.textAlignment = .right
        return label
    }()
    
    let timeSlider: UISlider = {
        let slider = UISlider()
        slider.maximumTrackTintColor = UIColor.white
        slider.minimumTrackTintColor = UIColor.red
//        slider.setThumbImage(UIImage(named: "thumb"), for: UIControl.State.normal)
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: UIControl.Event.valueChanged)
        return slider
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        setupPlayerView()
        containerView.frame = frame
        addSubview(containerView)
        
        containerView.addSubview(loadingPlayer)
        containerView.addSubview(playPauseButton)
        containerView.addSubview(currentLengthLabel)
        containerView.addSubview(videoLengthLabel)
        containerView.addSubview(timeSlider)
        setupGradientLayer()
      
        
        loadingPlayer.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingPlayer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        _ = videoLengthLabel.anchor(nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 2, rightConstant: 5, widthConstant: 50, heightConstant: 24)
        _ = timeSlider.anchor(nil, left: currentLengthLabel.rightAnchor, bottom: self.bottomAnchor, right: videoLengthLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        _ = currentLengthLabel.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 2, rightConstant: 0, widthConstant: 50, heightConstant: 20)
        
    }
    
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 2]
        containerView.layer.addSublayer(gradientLayer)
    }
    
    @objc func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalSecond = CMTimeGetSeconds(duration)
            let value = Float64(timeSlider.value) * totalSecond
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completeSeek) in
                //perhaps do something later here
            })
        }
        
    }
    
    @objc func handelPlayPause() {
        
        if isPlaying {
            player?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        } else {
            player?.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        }
        
        isPlaying = !isPlaying
    }
    
    private func setupPlayerView() {
        
        if let urlString = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") {
            
            player = AVPlayer(url: urlString)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondString = String(format: "%02d", Int(seconds) % 60)
                let minuteString = String(format: "%02d", Int(seconds) / 60)
                self.currentLengthLabel.text = "\(minuteString):\(secondString)"
                
                if let duration = self.player?.currentItem?.duration {
                    let durationSecond = CMTimeGetSeconds(duration)
                    self.timeSlider.value = Float(seconds / durationSecond)
                }
            })
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        loadingPlayer.stopAnimating()
        containerView.backgroundColor = UIColor.clear
        playPauseButton.isHidden = false
        
        if let duration = player?.currentItem?.duration {
            let second = CMTimeGetSeconds(duration)
            print(duration)
            print(second)
            let secondText = String(format: "%02d", Int(second) % 60)
            let minuteText = String(format: "%02d", Int(second) / 60)
            print(secondText)
            videoLengthLabel.text = "\(minuteText):\(secondText)"
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let videoPlayerHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerHeight)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            print(" \(keyWindow.frame.width) \(keyWindow.frame.height)")
            
            keyWindow.addSubview(view)
            view.addSubview(videoPlayerView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
            }) { (Bool) in
                // Maybe some code in here
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
    
}
