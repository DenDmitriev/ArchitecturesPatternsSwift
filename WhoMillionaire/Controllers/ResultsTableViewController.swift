//
//  ResultsTableViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    let cellIdentifier = "result"
    
    var results: [Result]!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
    }

    @IBAction func clearResultsAction(_ sender: UIBarButtonItem) {
        Game.shared.clearResults()
        results.removeAll()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ResultTableViewCell
        
        let result = results[indexPath.row]
        cell.dateLabel.text = result.date
        cell.scoreLabel.text = "$" + String(result.score)
        
        return cell
    }

}
