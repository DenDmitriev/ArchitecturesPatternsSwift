//
//  QuestionsTableViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 25.02.2021.
//

import UIKit

class QuestionsTableViewController: UITableViewController {
    
    var questions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadQuestions()
    }
    
    
    func setup() {
        tableView.register(QuestionHeaderView.self, forHeaderFooterViewReuseIdentifier: QuestionHeaderView.identifier)
    }
    
    func loadQuestions() {
        questions = QuestionService().questions(for: .user)
    }
    
    //MARK: - NavigationController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addQuestions":
            let questionAppendController = segue.destination as? QuestionAppendTableViewController
            questionAppendController?.delegate = self
        default:
            return
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[section].answers.count
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! QuestionHeaderView
        let question = questions[section]
        header.title.text = question.question

        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 73
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
        
        let question = questions[indexPath.section]
        let answer = question.answers[indexPath.row].answer
        cell.textLabel?.text = answer
        let right = question.answers[indexPath.row].right
        cell.accessoryType = right ? .checkmark : .none
        
        return cell
    }


}

extension QuestionsTableViewController: QuestionAppendTableViewControllerDelegate {
    
    func newQuestions() {
        loadQuestions()
        tableView.reloadData()
    }
}
