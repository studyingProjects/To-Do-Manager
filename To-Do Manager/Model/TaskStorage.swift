//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Andrei Shpartou on 16/02/2024.
//

import Foundation

protocol TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

class TaskStorage: TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol] {
        let testTasks: [TaskProtocol] = [
            Task(title: "Купить хлеб", type: .normal, status: .planned),
            Task(title: "Помыть кота", type: .important, status: .planned),
            Task(title: "Отдать долг Арнольду", type: .important, status: .completed),
            Task(title: "Купить новый пылесос", type: .normal, status: .completed),
            Task(title: "Выполнить задания по английскому", type: .important, status: .planned),
            Task(title: "Позвонить маме", type: .important, status: .planned) ]
        return testTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {

    }
    
    
}

