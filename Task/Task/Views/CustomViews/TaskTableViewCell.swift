//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Daniel Dickey on 4/21/21.
//

import UIKit

// MARK: - Protocol
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

// MARK: - Class
class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: TaskCompletionDelegate?
    var task: Task? { didSet { updateViews() } }
    
    // MARK: - Actions
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        
       if let delegate = delegate {
            
         delegate.taskCellButtonTapped(self)
            
       }
        
    }
    
    // MARK: - Functions
    
    func updateViews() {
        
        if let task = task {
            
            taskNameLabel.text = task.name
            
            if task.isComplete {
                completionButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
            } else {
                completionButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
            }
            
        }
        
    }
    
} //End of class
