//
//  TaskTableViewCell.swift
//  Tasker
//
//  Created by Denis Dmitriev on 12.03.2021.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func observe(task: Task, at indexPath: IndexPath)
}

class TaskTableViewCell: UITableViewCell {
    
    static let identifier = "TaskCell"

    var indexPath: IndexPath?
    var task: Task?
    
    weak var delegate: TaskTableViewCellDelegate?
    
    @IBOutlet weak var taskField: UITextField!
    @IBOutlet weak var subTasksCountLabel: UILabel!
    @IBOutlet weak var checkBoxButton: CheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func installation(for task: Task, in indexPath: IndexPath) {
        self.indexPath = indexPath
        self.task = task
        taskField.text = task.name
        checkBoxButton.check = task.isCompleted
        guard let task = task as? CompositeTask else { return }
        switch task.tasks.count {
        case 0:
            subTasksCountLabel.text = "Contains no tasks"
        default:
            subTasksCountLabel.text = "Contains \(task.tasks.count) tasks"
        }
    }
    
    private func save() {
        guard let task = task, let indexPath = indexPath else { return }
        delegate?.observe(task: task, at: indexPath)
    }
    
    
    //MARK: - Actions
    
    @IBAction func taskEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        task?.name = text
        save()
    }
    @IBAction func checkBoxTouch(_ sender: CheckBox) {
        task?.isCompleted = !sender.check
        save()
    }
    
}
