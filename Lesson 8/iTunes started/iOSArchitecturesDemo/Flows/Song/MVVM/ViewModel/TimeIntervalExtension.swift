//
//  TimeIntervalExtension.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 20.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

extension TimeInterval {
    func timecode() -> String {
        let durationInSeconds = Int(self)
        
        let minutes = durationInSeconds / 60
        let seconds = durationInSeconds - minutes * 60
        
        return String(format: "%02d:%02d", minutes,seconds) as String
    }
}
