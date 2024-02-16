//
//  Task.swift
//  To-Do Manager
//
//  Created by Andrei Shpartou on 16/02/2024.
//

import Foundation

protocol TaskProtocol {
    var title: String { get set }
    var type: TaskPriority { get set }
    var status: TaskStatus { get set }
}

enum TaskPriority {
    case normal
    case important
}

enum TaskStatus: Int {
    case planned
    case completed
}


struct Task: TaskProtocol {
    var title: String
    var type: TaskPriority
    var status: TaskStatus
}

