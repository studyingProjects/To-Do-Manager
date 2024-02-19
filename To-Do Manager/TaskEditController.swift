//
//  TaskEditController.swift
//  To-Do Manager
//
//  Created by Andrei Shpartou on 17/02/2024.
//

import UIKit

class TaskEditController: UITableViewController {

    @IBOutlet var taskTitle: UITextField!
    @IBOutlet var taskTypeLabel: UILabel!
    @IBOutlet var taskStatusSwitch: UISwitch!
    
    var taskText: String = ""
    var taskType: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    private var taskTitles: [TaskPriority: String] = [
        .important: "Important",
        .normal: "Current"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // обновление текстового поля с названием задачи
        taskTitle?.text = taskText
        // обновление метки в соответствии текущим типом
        taskTypeLabel.text = taskTitles[taskType]
        // обновляем статус задачи
        if taskStatus == .completed {
            taskStatusSwitch.isOn = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTypeScreen" {
            // ссылка на контроллер назначения
            let destination = segue.destination as! TaskTypeController
            // передача выбранного типа
            destination.selectedType = taskType
            // передача обработчика выбора типа
            destination.doAfterTypeSelected = { [unowned self] selectedType in
                self.taskType = selectedType
                // обновляем метку с текущим типом
                self.taskTypeLabel?.text = self.taskTitles[self.taskType]
            }
        }
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        // получаем актуальные значения
        let title = taskTitle?.text ?? ""
        guard !title.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Fill in the title to save remind", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(actionCancel)
            self.present(alert, animated: true)
            return
        }
        
        let type = taskType
        let status: TaskStatus = taskStatusSwitch.isOn ? .completed : .planned
        // вызываем обработчик
        doAfterEdit?(title, type, status)
        // возвращаемся к предыдущему экрану
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

}
