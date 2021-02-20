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
    
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        loadGameSession()
        loadQuestion()
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
    
    //MARK: - Action
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        guard let answer = sender.title(for: .normal),
              let check = gameSession.questions[index].answers[answer]
        else { return }
        
        switch check {
        case true:
            print("Верно")
        case false:
            //sender.isEnabled = false
            print("Не верно")
        }
        
        delegate.progress(for: index, with: check)
        
        if (index + 1) < gameSession.questions.count, check {
            index += 1
            loadQuestion()
        } else {
            delegate.endGame()
            navigationController?.popViewController(animated: true)
        }
    }
}
