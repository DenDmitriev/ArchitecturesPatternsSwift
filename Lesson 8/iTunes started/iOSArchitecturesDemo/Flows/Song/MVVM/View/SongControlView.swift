//
//  SongControlView.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SongControlViewOutput: AnyObject {
    func playAction(sender: UIButton)
    func stopAction(sender: UIButton)
}

class SongControlView: UIView {
    
    weak var viewController: SongControlViewOutput?
    
    private(set) lazy var timecodeCurrentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "--:--"
        return label
    }()
    
    private(set) lazy var timecodeDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "--:--"
        return label
    }()
    
    private(set) lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.tintColor = .systemRed
        return progress
    }()
    
    private(set) lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .systemRed
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(playAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var stopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.tintColor = .systemRed
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(stopAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        self.addSubview(progressView)
        self.addSubview(timecodeCurrentLabel)
        self.addSubview(timecodeDurationLabel)
        
        let stackView = UIStackView(arrangedSubviews: [stopButton, playButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            progressView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            progressView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            progressView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            timecodeCurrentLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 4),
            timecodeCurrentLabel.leftAnchor.constraint(equalTo: self.progressView.leftAnchor),
            
            timecodeDurationLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 4),
            timecodeDurationLabel.rightAnchor.constraint(equalTo: self.progressView.rightAnchor),
            
            playButton.widthAnchor.constraint(equalToConstant: 48),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
            
            stopButton.widthAnchor.constraint(equalToConstant: 48),
            stopButton.heightAnchor.constraint(equalTo: stopButton.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 12),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    //MARK: - Actions
    
    @objc func playAction(sender: UIButton) {
        viewController?.playAction(sender: sender)
    }
    
    @objc func pauseAction(sender: UIButton) {
        
    }
    
    @objc func stopAction(sender: UIButton) {
        viewController?.stopAction(sender: sender)
    }
    
    //MARK: - Update
    
    func updatePlayButton(isPlaying: Bool) {
        switch isPlaying {
        case true:
            self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        case false:
            self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    func updateTimecode(timecode: String) {
        self.timecodeCurrentLabel.text = timecode
    }
    
    func trackAvailable(isAvailable: Bool, with duration: String?) {
        self.playButton.isEnabled = isAvailable
        self.stopButton.isEnabled = isAvailable
        self.timecodeDurationLabel.text = duration
    }
}
