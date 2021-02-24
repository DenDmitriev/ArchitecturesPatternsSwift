//
//  GameViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func progress(for index: Int, with value: Bool)
    func endGame()
}

class GameViewController: UIViewController {
    
    var gameSession: GameSession!
    var questionNumber: Int!
    
    weak var delegate: GameViewControllerDelegate!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var scoreBarBurron: UIBarButtonItem!
    
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        loadGameSession()
        
        if checkQuestions() {
            loadQuestion()
        } else {
            questionsError()
        }
    }
    
    
    //MARK: - Setup
    
    func loadGameSession() {
        gameSession = GameSession()
        Game.shared.gameSession = gameSession
        delegate = gameSession
    }
    
    private func style() {
        navigationController?.navigationBar.isHidden = false
        answerButtons.forEach { (button) in
            button.layer.cornerRadius = 16
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(UIColor.gray, for: .disabled)
            button.setBackgroundColor(color: UIColor.darkGray, forState: .disabled)
        }
        
    }
    
    func checkQuestions() -> Bool {
        if gameSession.questions.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    
    func loadQuestion() {
        title = "Вопрос \(index + 1)"
        let question = gameSession.questions[index]
        questionLabel.text = question.question
        let answers = question.answers.keys.shuffled()
        answerButtons.enumerated().forEach { (index, button) in
            let answer = answers[index] as String
            button.setTitle(answer, for: .normal)
            button.isEnabled = true
        }
    }
    
    //MARK: - Alerts
    
    fileprivate func questionsError() {
        let alert = UIAlertController(title: "Нет вопросов", message: "Чтобы добавить вопросы:\n Перейдите в меню -> Добавить вопрос", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Action
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        guard let answer = sender.title(for: .normal),
              let check = gameSession.questions[index].answers[answer]
        else { return }
        
        if (index + 1) < gameSession.questions.count, check {
            index += 1
            loadQuestion()
            delegate.progress(for: index, with: check)
            scoreBarBurron.title = "$" + String(gameSession.result.score)
        } else {
            delegate.endGame()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func saveMoneyAction(_ sender: UIBarButtonItem) {
        delegate.endGame()
        navigationController?.popViewController(animated: true)
    }
}