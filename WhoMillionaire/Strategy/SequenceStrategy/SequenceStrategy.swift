//
//  SequenceStrategy.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 24.02.2021.
//

import Foundation

protocol SequenceStrategy: AnyObject {
    func createQuestions(_ questions: [Question]) -> [Question]
}
