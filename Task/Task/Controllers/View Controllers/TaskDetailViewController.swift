//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Daniel Dickey on 4/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

    }
    
    // MARK: - Properties
    
    var task: Task?
    var date: Date?
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        let taskDueDate = date
        
        guard let taskName = taskNameTextField.text, !taskName.isEmpty,
              let taskNotes = taskNotesTextView.text else {return}
        
        if let task = task {
            TaskController.shared.update(task: task, name: taskName, notes: taskNotes, dueDate: taskDueDate)
        } else {
            TaskController.shared.createTaskWith(name: taskName, notes: taskNotes, dueDate: taskDueDate)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        
        date = taskDueDatePicker.date
        
    }
    
    // MARK: - Functions
    
    func updateViews() {
        
        if let task = task {
            taskNameTextField.text = task.name
            taskNotesTextView.text = task.notes
            taskDueDatePicker.date = task.dueDate ?? Date()
        }
        
    }

} //End of class
