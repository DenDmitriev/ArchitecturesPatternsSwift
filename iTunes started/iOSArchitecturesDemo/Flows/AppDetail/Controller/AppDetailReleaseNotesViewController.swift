//
//  AppDetailReleaseNotesViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 17.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailReleaseNotesViewController: UIViewController {
    
    private let app: ITunesApp
    
    private var appDetailReleaseNotesView: AppDetailReleaseNotesView {
        return self.view as! AppDetailReleaseNotesView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailReleaseNotesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congureUI()
    }
    
    private func congureUI() {
        appDetailReleaseNotesView.versionLabel.text?.append(app.version)
        appDetailReleaseNotesView.releaseDateLabel.text = relativeDate()
        appDetailReleaseNotesView.releaseNotesLabel.text = app.releaseNotes
    }
    
    private func relativeDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        return formatter.localizedString(for: app.currentReleaseDate, relativeTo: Date())
    }
}
