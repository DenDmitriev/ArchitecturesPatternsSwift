//
//  QuestionsStrategy.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 01.03.2021.
//

import Foundation

protocol QuestionsStrategy: AnyObject {
    func createQuestions() -> [Question]
}
