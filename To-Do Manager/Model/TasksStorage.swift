//
//  TasksStorage.swift
//  To-Do Manager
//
//  Created by Andrei Shpartou on 16/02/2024.
//
//            Task(title: "Купить хлеб", type: .normal, status: .planned),
//            Task(title: "Помыть кота", type: .important, status: .planned),
//            Task(title: "Отдать долг Арнольду", type: .important, status: .completed),
//            Task(title: "Купить новый пылесос", type: .normal, status: .completed),
//            Task(title: "Выполнить задания по английскому", type: .important, status: .planned),
//            Task(title: "Пригласить на вечеринку Диму, Илью, Дашу, Мишу", type: .important, status: .planned),
//            Task(title: "Позвонить маме", type: .important, status: .planned)

import Foundation

protocol TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

class TasksStorage: TasksStorageProtocol {
    // Ссылка на хранилище
    private var storage = UserDefaults.standard
    // Ключ по которому будет происходить сохранение и загрузка хранилища из UserDefaults
    var storageKey: String = "tasks"
    // Перечисление с ключами для записи в UserDefaults
    private enum TaskKey: String {
        case title
        case type
        case status
    }
    
    func loadTasks() -> [TaskProtocol] {
        var resultTasks: [TaskProtocol] = []
        let tasksFromStorage = storage.array(forKey: storageKey) as? [[String: String]] ?? []
        for task in tasksFromStorage {
            guard let title = task[TaskKey.title.rawValue],
                  let typeRaw = task[TaskKey.type.rawValue],
                  let statusRaw = task[TaskKey.status.rawValue] else {
                continue
            }
            let type: TaskPriority = typeRaw == "important" ? .important : .normal
            let status: TaskStatus = statusRaw == "planned" ? .planned : .completed
            resultTasks.append(Task(title: title, type: type, status: status))
        }
        
        return resultTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        var arrayForStorage: [[String:String]] = []
        tasks.forEach { task in
            var newElementForStorage: Dictionary<String, String> = [:] 
            newElementForStorage[TaskKey.title.rawValue] = task.title
            newElementForStorage[TaskKey.type.rawValue] = (task.type == .important) ? "important" : "normal"
            newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
    
    
}

