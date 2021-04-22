//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Daniel Dickey on 4/21/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TaskController.shared.loadFromPersistenceStore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        
        let task = TaskController.shared.tasks[indexPath.row]
        
        cell.task = task
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            
            guard let destinationVC = segue.destination as? TaskDetailViewController,
                  let indexPath = tableView.indexPathForSelectedRow else {return}
            
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            
            destinationVC.task = taskToSend
            
        }
        
    }
   
}//End of class


extension TaskListTableViewController: TaskCompletionDelegate {
    
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        
        guard let task = sender.task else {return}
        
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateViews()
        
    }
    
} //End of extension
