//
//  TaskTableViewController.swift
//  Tasker
//
//  Created by Denis Dmitriev on 12.03.2021.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    var task: CompositeTask = TaskCache.shared.task {
        didSet {
            title = task.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        print(task.description)
    }
    
    //MARK: - Private
    
    fileprivate func installation() {
        title = task.name
        tableView.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
    
    //MARK: - Public
    
    func setup(for mainTask: CompositeTask) {
        self.task = mainTask
    }
    
    //MARK: - Actions
    
    @IBAction func addTaskBarButton(_ sender: UIBarButtonItem) {
        let newTask = SingleTask(name: "")
        task.tasks.append(newTask)
        let newIndexPath = IndexPath(row: task.tasks.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .right)
    }
    
    
    //MARK: - DataSource
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        task.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        cell.installation(for: task.tasks[indexPath.row], in: indexPath)
        cell.delegate = self
        return cell
    }
    
    //MARK: - Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        guard let taskTableViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Tasks") as? TaskTableViewController else { return }
        
        if let singleTask = task.tasks[indexPath.row] as? SingleTask {
            let compositeTask = CompositeTask(from: singleTask)
            task.tasks[indexPath.row] = compositeTask
            taskTableViewController.setup(for: compositeTask)
        } else {
            taskTableViewController.setup(for: task.tasks[indexPath.row] as! CompositeTask)
        }

        navigationController?.pushViewController(taskTableViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            task.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        default:
            return
        }
    }

}

extension TaskTableViewController: TaskTableViewCellDelegate {
    
    func observe(task: Task, at indexPath: IndexPath) {
        self.task.tasks[indexPath.row] = task
    }
}

