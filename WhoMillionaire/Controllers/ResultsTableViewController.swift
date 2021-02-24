//
//  ResultsTableViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
    }

    @IBAction func clearResultsAction(_ sender: UIBarButtonItem) {
        Game.shared.clearResults()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell
        
        let result = Game.shared.results[indexPath.row]
        cell.dateLabel.text = result.date
        cell.scoreLabel.text = "$" + String(result.score)
        cell.percentLabel.text = String(result.percent) + "%"
        
        return cell
    }
}
