//
//  QuestionAppendTableViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 26.02.2021.
//

import UIKit

protocol QuestionAppendTableViewControllerDelegate: AnyObject {
    func newQuestions()
}

class QuestionAppendTableViewController: UITableViewController {
    
    var questions: [Question] = []
    
    weak var delegate: QuestionAppendTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        addEmptyForm()
    }
    
    private func addEmptyForm() {
        let emptyAnswers = [
            Answer(answer: "", right: true),
            Answer(answer: "", right: false),
            Answer(answer: "", right: false),
            Answer(answer: "", right: false)
        ]
        let emptyQuestion = Question(custom: "", with: emptyAnswers)
        questions.append(emptyQuestion)
        print(questions)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case self.questions.count:
            //Секция с кнопкой добавления новой формы
            return 1
        default:
            //Секцию с формой добавления
            return QuestionCellType.allCases.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.section != questions.count else {
            let identifier = ActionsQuestionsTableViewCell.identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ActionsQuestionsTableViewCell
            cell.delegate = self
            return cell
        }
        
        let cellType = QuestionCellType(rawValue: indexPath.row) ?? .question
        
        var identifier = ""
        switch cellType {
        case .question:
            identifier = QuestionAppendCellTableViewCell.identifier
        case .answerOne:
            identifier = AnswersAppendTableViewCell.identifier
        case .answerTwo:
            identifier = AnswersAppendTableViewCell.identifier
        case .answerThree:
            identifier = AnswersAppendTableViewCell.identifier
        case .answerFour:
            identifier = AnswersAppendTableViewCell.identifier
        case .remove:
            identifier = RemoveQuestionTableViewCell.identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RemoveQuestionTableViewCell
            cell.removeForm = {
                let section = indexPath.section
                self.questions.remove(at: section)
                self.tableView.deleteSections(IndexSet(integer: section), with: .automatic)
            }
            return cell
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! QuestionCell
        
        cell.editingDidEnd = { [weak self] textField in
            self?.getText(cellType: cellType, textField: textField)
        }

        cell.setup(type: cellType)

        return cell
    }
    
    //MARK: - Builder
    
    private func buildQuestions() -> [Question] {
        var exportQuestions: [Question] = []
        questions.forEach { question in
            let builder = QuestionBuilder()
            builder.setQuestion(question)
            do {
                let exportQusetion = try builder.build()
                exportQuestions.append(exportQusetion)
            } catch {
                print(error)
            }
        }
        return exportQuestions
    }
    
    //MARK: - Get data from cell
    
    private func getText(cellType: QuestionCellType, textField: UITextField) {
        guard
            let indexPath = getIndexPathFromSuperview(cellType: cellType, sender: textField),
            let text = textField.text
        else { return }
        switch cellType {
        case .question:
            questions[indexPath.section].question = text
        default:
            questions[indexPath.section].answers[indexPath.row - 1].answer = text
        }
    }
    
    
    private func getIndexPathFromSuperview(cellType: QuestionCellType, sender: UITextField) -> IndexPath? {
        switch cellType {
        case .question:
            guard let cell = sender.superview?.superview as? QuestionAppendCellTableViewCell,
                  let indexPath = tableView.indexPath(for: cell)
            else { return nil }
            return indexPath
        default:
            guard let cell = sender.superview?.superview?.superview as? AnswersAppendTableViewCell,
                  let indexPath = tableView.indexPath(for: cell)
            else { return nil }
            return indexPath
        }
        
    }
    
    //MARK: - Actions
    
    @IBAction func rightAnswerSwitcherCnaged(_ sender: UISwitch) {
        guard let cell = sender.superview?.superview?.superview as? AnswersAppendTableViewCell,
              let indexPath = tableView.indexPath(for: cell)
        else { return }
        
        switch cell.trueSwitch.isOn {
        case true:
            let falseAnswers: [QuestionCellType] = [.answerOne, .answerTwo, .answerThree, .answerFour].filter { $0.rawValue != indexPath.row }
            falseAnswers.forEach { (answer) in
                let indexPathFalse = IndexPath(row: answer.rawValue, section: indexPath.section)
                guard let cell = tableView.cellForRow(at: indexPathFalse) as? AnswersAppendTableViewCell else { return }
                cell.trueSwitch.isOn = false
                questions[indexPathFalse.section].answers[indexPathFalse.row - 1].right = false
            }
        case false:
            cell.trueSwitch.isOn = true
        }
    }
    

}

extension QuestionAppendTableViewController: ActionsQuestionsTableViewCellDelegate {
    
    func saveQuestions() {
        view.endEditing(true)
        
        let exportQuestions = buildQuestions()
        QuestionService.shared.saveQuestions(exportQuestions)
        
        dismiss(animated: true) {
            self.delegate?.newQuestions()
        }
    }
    
    func addEmptyQuestion() {
        
        self.tableView.beginUpdates()
        self.addEmptyForm()
        //Добавляю новые кнопки
        self.tableView.insertSections(IndexSet(integer: questions.count), with: .automatic)
        //Перезагружаю старый раздел кнопок на форму
        self.tableView.reloadSections(IndexSet(integer: questions.count - 1), with: .automatic)
        self.tableView.endUpdates()
    }
}
