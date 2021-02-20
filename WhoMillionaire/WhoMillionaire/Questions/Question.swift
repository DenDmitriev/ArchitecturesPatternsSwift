//
//  Question.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import Foundation

struct Question: Codable {
    let question: String
    let answers: [String:Bool]
}
