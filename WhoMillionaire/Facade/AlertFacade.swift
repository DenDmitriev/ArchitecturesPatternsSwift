//
//  AlertFacade.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 25.02.2021.
//

import UIKit

final class AlertFacade {
    
    //MARK: - Alerts
    
    func callAlert(_ answer: String, _ answerButton: UIButton, handler: @escaping (() -> Void)) -> UIAlertController {
        
        let title = "Звонок Володе..."
        let message = "Дмитрий, я считаю правильный ответ - \(answer)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let believe = UIAlertAction(title: "Поверить", style: .default) { _ in
            handler()
        }
        alert.addAction(believe)
        
        let unbelieve = UIAlertAction(title: "Не верить", style: .cancel, handler: nil)
        alert.addAction(unbelieve)
        
        setAlertStyle(alert)
        
        return alert
    }
    
    func fiftyFiftyAlert(_ fiftyFifty: [String]) -> UIAlertController {
        
        let title = "Компьютер убрал два неверных ответа"
        let message = fiftyFifty.first! + " и " + fiftyFifty.last!
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ок", style: .cancel)
        alert.addAction(action)
        
        setAlertStyle(alert)
        
        return alert
    }
    
    func hallAlert(_ hallAnswers: [(key: String, value: Int)]) -> UIAlertController {
        
        let title = "Зал проголосовал"
        var message: String = ""
        hallAnswers.forEach { message += $0.key + " " + String($0.value) + "%\n" }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        
        setAlertStyle(alert)
        
        return alert
    }
    
    func questionsErrorAlert(handler: @escaping (() -> Void)) -> UIAlertController {
        let alert = UIAlertController(title: "Нет вопросов", message: "Чтобы добавить вопросы:\n Перейдите в меню -> Добавить вопрос", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            handler()
        }
        alert.addAction(action)
        
        setAlertStyle(alert)

        return alert
    }
    
    //MARK: - Game life circle
    
    func gameOverAlert(gameSession: GameSession, index: Int, handler: @escaping (() -> Void)) -> UIAlertController {
        
        let title = "Вы проиграли"
        
        let helpers = formatHelpers(gameSession: gameSession)
        let message = "Вопросов отвечено: \(index)\n" + helpers
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ок", style: .cancel) { _ in
            handler()
        }
        alert.addAction(action)
        
        setAlertStyle(alert)
        
        return alert
    }
    
    func gameWinerAlert(gameSession: GameSession, index: Int, handler: @escaping (() -> Void)) -> UIAlertController {
        
        let title = "Вы выиграли \(gameSession.result.score)$"
        
        let helpers = formatHelpers(gameSession: gameSession)
        let message = "Вопросов отвечено: \(index + 1)\n" + helpers
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ок", style: .cancel) { _ in
            handler()
        }
        alert.addAction(action)
        
        setAlertStyle(alert)
        
        return alert
    }
    
    func gameTakeMoneyAlert(gameSession: GameSession, index: Int, handler: @escaping (() -> Void)) -> UIAlertController {
        
        let title = "Вы забрали \(gameSession.result.score)$"
        
        let helpers = formatHelpers(gameSession: gameSession)
        let message = "Вопросов отвечено: \(index)\n" + helpers
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ок", style: .cancel) { _ in
            handler()
        }
        alert.addAction(action)
        
        setAlertStyle(alert)
        
        return alert
    }
    
    //MARK: - Alerts service
    
    fileprivate func formatHelpers(gameSession: GameSession) -> String {
        let helpers = gameSession.helpers.filter { !$0.value }
        if helpers.count == 0 {
            return "Подсказки не были использованы"
        } else {
            var message: String = ""
            helpers
                .compactMap { $0.key.rawValue.lowercased() }
                .forEach { message.append($0 + ", ") }
            return "Использованы подсказки: \(String(message.dropLast(2)))"
        }
    }
    
    fileprivate func setAlertStyle(_ alert: UIAlertController) {
        alert.view.tintColor = .systemYellow
        alert.setFontColor(.white, .white)
        alert.setbackgroundColor(.darkGray)
    }
    
}
