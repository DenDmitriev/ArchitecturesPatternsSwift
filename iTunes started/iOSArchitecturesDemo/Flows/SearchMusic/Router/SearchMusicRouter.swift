//
//  SearchMusicRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchMusicRouterInput {
    
    func openSong(for song: ITunesSong)
    
}

class SearchMusicRouter: SearchMusicRouterInput {
    
    weak var viewController: UIViewController?
    
    func openSong(for song: ITunesSong) {
        let songViewController = SongViewController(song: song)
        viewController?.navigationController?.pushViewController(songViewController, animated: true)
    }
}
