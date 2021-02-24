//
//  SettingsTableViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 24.02.2021.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var shuffleSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
    }
    
    private func loadSettings() {
        shuffleSwitch.isOn = Game.shared.user.shuffle
    }
    

    @IBAction func sequenceStrategySwitch(_ sender: UISwitch) {
        print(#function)
        Game.shared.user.shuffle = sender.isOn
        saveSettings()
    }
    
    private func saveSettings() {
        let caretaker = CareTaker()
        caretaker.saveUser(user: Game.shared.user)
    }

    
}
