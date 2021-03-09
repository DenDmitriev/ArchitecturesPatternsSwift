//
//  MenuViewController.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let twoGameSegueIdentifier = "twoGame"
    private let oneGameSegueIdentifier = "oneGame"
    private let blindlyGameSegueIdentifier = "blindlyGame"
    
    @IBOutlet var menuButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        // Do any additional setup after loading the view.
    }
    
    private func setStyle() {
        menuButtons.forEach { button in
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 4
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case twoGameSegueIdentifier:
            Session.shared.strategy = TwoGameMode()
        case oneGameSegueIdentifier:
            Session.shared.strategy = OneGameMode()
        case blindlyGameSegueIdentifier:
            Session.shared.strategy = BlindlyPrepareMode()
        default:
            return
        }
    }
    
    //MARK: - Actions
    
    @IBAction func twoGameAction(_ sender: UIButton) {
        performSegue(withIdentifier: twoGameSegueIdentifier, sender: nil)
    }
    
    @IBAction func oneGameAction(_ sender: UIButton) {
        performSegue(withIdentifier: oneGameSegueIdentifier, sender: nil)
    }
    
    @IBAction func blindlyGameAction(_ sender: UIButton) {
        performSegue(withIdentifier: blindlyGameSegueIdentifier, sender: nil)
    }
    

}
