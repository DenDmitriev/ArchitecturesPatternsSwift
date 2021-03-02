//
//  GameViewController.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func progress()
    func endGame(_ check: Bool)
    func usedHelper(_ helper: Helpers)
}

class GameViewController: UIViewController {
    
    var gameSession: GameSession!
    
    weak var delegate: GameViewControllerDelegate!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var curentQuestionNumberLabel: UILabel!
    @IBOutlet weak var percentTrueAnswersLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet var helperButtons: [UIButton]!
    
    @IBOutlet weak var scoreBarBurron: UIBarButtonItem!
    
    //MARK: - Life Circel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        loadGameSession()
        observe()
        startGame()
    }
    
    deinit {
        removeObservers()
    }
    
    //MARK: - Setup
    
    func loadGameSession() {
        gameSession = GameSession()
        Game.shared.gameSession = gameSession
        delegate = gameSession
    }
    
    fileprivate func observe() {
        gameSession.current.addObserver(self, options: [.initial, .new]) { [weak self] (index, _) in
            let count = self?.gameSession.count ?? 0
            self?.curentQuestionNumberLabel.text = "Вопрос \(index + 1) из \(count)"
        }
        gameSession.percent.addObserver(self, options: [.initial, .new]) { [weak self] (percent, _) in
            self?.percentTrueAnswersLabel.text = "Верных \(percent)%"
        }
        gameSession.score.addObserver(self, options: [.initial, .new]) { [weak self] (money, _) in
            self?.scoreBarBurron.title = "\(money)$"
        }
    }
    
    fileprivate func removeObservers() {
        gameSession.current.removeObserver(self)
        gameSession.percent.removeObserver(self)
        gameSession.score.removeObserver(self)
    }
    
    private func setStyle() {
        navigationController?.navigationBar.isHidden = false
        answerButtons.forEach { (button) in
            button.layer.cornerRadius = button.frame.height
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(UIColor.gray, for: .disabled)
            button.setBackgroundColor(color: UIColor.darkGray, forState: .disabled)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.5
        }
        helperButtons.forEach { (button) in
            button.imageView?.contentMode = .scaleAspectFit
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.contentMode = .scaleAspectFit
        }
        
    }
    
    private func startGame() {
        if gameSession.count == 0 {
            questionsError()
        } else {
            loadQuestion()
        }
    }
    
    
    func loadQuestion() {
        
        let question = gameSession.questions[gameSession.current.value]
        questionLabel.text = question.question
        
        let answers = question.answers.shuffled()
        answerButtons.enumerated().forEach { (index, button) in
            let answer = answers[index].answer as String
            button.setTitle(answer, for: .normal)
            button.isEnabled = true
        }

        helperButtons.forEach { (button) in
            gameSession.helpers.forEach { (key, value) in
                if button.restorationIdentifier == key.rawValue {
                    button.isEnabled = value
                }
            }
        }
        
        gameSession.hintUsageFacade = HintUsageFacade(question)
    }
    
    //MARK: - Error
    
    fileprivate func questionsError() {
        let alert = AlertFacade().questionsErrorAlert {
            self.navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Action
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        guard let answer = sender.title(for: .normal),
              let check = gameSession.questions[gameSession.current.value].answers.filter({ $0.answer == answer }).first?.right
        else { return }
        
        if (gameSession.current.value + 1) < gameSession.count, check {
            delegate.progress()
            loadQuestion()
        } else if check {
            let alert = AlertFacade().gameWinerAlert(gameSession: gameSession, index: gameSession.current.value) {
                self.delegate.progress()
                self.delegate.endGame(check)
                self.navigationController?.popViewController(animated: true)
            }
            present(alert, animated: true)
        } else {
            let alert = AlertFacade().gameOverAlert(gameSession: gameSession, index: gameSession.current.value) {
                self.delegate.endGame(check)
                self.navigationController?.popViewController(animated: true)
            }
            present(alert, animated: true)
        }
    }
    
    @IBAction func saveMoneyAction(_ sender: UIBarButtonItem) {
        let alert = AlertFacade().gameTakeMoneyAlert(gameSession: gameSession, index: gameSession.current.value) {
            self.delegate.endGame(true)
            self.navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true)
    }
    
    //MARK:  Helpers Actions
    
    @IBAction func callFriendAction(_ sender: UIButton) {
 
        guard let answer = gameSession.hintUsageFacade?.callFriend() else { return }
        
        var answerButton: UIButton!
        for button in answerButtons {
            if button.titleLabel?.text == answer {
                answerButton = button
            }
        }
    
        let alert = AlertFacade().callAlert(answer, answerButton) {
            self.selectAnswer(answerButton)
        }
        present(alert, animated: true)
        
        sender.isEnabled = false
        delegate.usedHelper(.call)
    }
    
    @IBAction func hallHelpAction(_ sender: UIButton) {

        guard let hallAnswers = gameSession.hintUsageFacade?.useAuditoryHelp() else { return }
        
        let alert = AlertFacade().hallAlert(hallAnswers)
        present(alert, animated: true)
        
        sender.isEnabled = false
        self.delegate.usedHelper(.hall)
    }
    
    @IBAction func fiftyFiftyAction(_ sender: UIButton) {
        
        guard let fiftyFifty = gameSession.hintUsageFacade?.use50to50Hint() else { return }
        
        fiftyFifty.forEach { (answer) in
            answerButtons.forEach { (button) in
                if button.titleLabel?.text == answer {
                    button.isEnabled = false
                }
            }
        }

        let alert = AlertFacade().fiftyFiftyAlert(fiftyFifty)
        present(alert, animated: true)
        
        sender.isEnabled = false
        delegate.usedHelper(.fifty)
    }
    
}
