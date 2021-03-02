//
//  SettingsTableViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 24.02.2021.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var shuffleSwitch: UISwitch!
    @IBOutlet weak var customSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        loadSettings()
    }
    
    private func style() {
        tableView.tableFooterView = UIView()
    }
    
    private func loadSettings() {
        shuffleSwitch.isOn = Game.shared.user.shuffle
        customSwitch.isOn = Game.shared.user.custom
        
    }
    
    @IBAction func sequenceStrategySwitch(_ sender: UISwitch) {
        print(#function)
        Game.shared.user.shuffle = sender.isOn
        saveSettings()
    }
    
    @IBAction func questionsStrategySwitch(_ sender: UISwitch) {
        Game.shared.user.custom = sender.isOn
        saveSettings()
    }
    
    
    private func saveSettings() {
        let caretaker = CareTaker()
        caretaker.saveUser(user: Game.shared.user)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }

    
}
