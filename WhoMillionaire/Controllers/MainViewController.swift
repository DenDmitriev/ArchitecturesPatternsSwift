//
//  MainViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let startGameSegueIdentifier = "startGame"
    private let resultsGameSegueIdentifier = "resultsTable"
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func load() {
        Game.shared.delegate = self
    }
    
    private func style() {
        navigationController?.navigationBar.isHidden = true
        buttons.forEach { (button) in
            button.layer.cornerRadius = button.bounds.height/2
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case resultsGameSegueIdentifier:
            print(#function + " go to results table")
        case startGameSegueIdentifier:
            print(#function + " go to game controller")
        default:
            return
        }
    }

    @IBAction func startAction(_ sender: UIButton) {
        performSegue(withIdentifier: startGameSegueIdentifier, sender: nil)
    }
    
    @IBAction func recordsAction(_ sender: UIButton) {
        performSegue(withIdentifier: resultsGameSegueIdentifier, sender: nil)
    }
    
}

extension MainViewController: GameDelegate {
    func endGame(with score: Int) {
        scoreLabel.text = "Заработано: $" + String(score)
    }
}
