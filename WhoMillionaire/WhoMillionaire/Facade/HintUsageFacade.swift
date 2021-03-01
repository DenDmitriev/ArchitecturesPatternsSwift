//
//  HintUsageFacade.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 01.03.2021.
//

import UIKit

final class HintUsageFacade {
    
    var question: String
    var answers: [Answer]
    
    init(_ question: Question) {
        self.question = question.question
        self.answers = question.answers
    }
    
    //MARK: - Methods
    
    func useAuditoryHelp() -> Array<(key: String, value: Int)>? {
        guard check(.hall) else { return nil }
        
        var hallAnswers: [String: Int] = [:]
        
        enum Vote: CaseIterable {
            case one, two, three, four
        }
        var votes: [Vote: Int] = [:]
        
        var max = 100
        let min = Int.random(in: 0...33)
        votes[.one] = Int.random(in: min...max)
        max = 100 - (votes[.one] ?? 50)
        votes[.two] = Int.random(in: 0...max)
        max = 100 - (votes[.one] ?? 50) - (votes[.two] ?? 25)
        votes[.three] = Int.random(in: 0...max)
        votes[.four] = max - (votes[.three] ?? 12)
        
        var cases: [Vote] = Vote.allCases.filter { $0 != .one }
        for answer in answers {
            if answer.right {
                hallAnswers[answer.answer] = votes[.one]
            } else {
                hallAnswers[answer.answer] = votes[cases.first!]
                cases.removeFirst()
            }
        }
        
        let hall = hallAnswers.sorted(by: { $0.value >= $1.value })
        
        return hall
    }
    

    func callFriend() -> String? {
        guard check(.call) else { return nil }
        
        let friendKnows: Bool = {
            if Int.random(in: 0...5) == 0 {
                return false
            } else {
                return true
            }
        }()
        
        var answerFriend: String = ""
        answers.forEach { answer in
            switch friendKnows {
            case true:
                if answer.right {
                    answerFriend = answer.answer
                    break
                }
            case false:
                if !answer.right {
                    answerFriend = answer.answer
                    break
                }
            }
        }
        
        return answerFriend
    }
    
    func use50to50Hint() -> [String]? {
        guard check(.fifty) else { return nil }
        
        var answersFiftyFifty: [String] = []
        
        for answer in answers.shuffled() {
            guard !answer.right else { continue }
            answersFiftyFifty.append(answer.answer)
            guard answersFiftyFifty.count == 2 else { continue }
            break
        }
        
        return answersFiftyFifty
    }
    
    //MARK: - Helpers
    
    private func check(_ helper: Helpers) -> Bool {
        guard let check = Game.shared.gameSession?.helpers[helper] else { return false }
        return check
    }
}
