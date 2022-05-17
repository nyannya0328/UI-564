//
//  TakViewModel.swift
//  UI-564
//
//  Created by nyannyan0328 on 2022/05/17.
//

import SwiftUI
import CoreData

class TakViewModel: ObservableObject {
    @Published var currentTab : String = "Today"
    
    @Published var taskColor : String = "Yellow"
    @Published var openEditTask : Bool = false
    @Published var taskTitle : String = ""
    @Published var taskDedline : Date = Date()
    @Published var taskType : String = "Basic"
    
    @Published var showDatePicker : Bool = false
    
    @Published var editTask : Task?
    
    
    func addToTask(contex : NSManagedObjectContext) -> Bool{
        
        var task : Task!
        
        if let editTask = editTask {
            
            task = editTask
        }
        else{
            
            task = Task(context: contex)
        }
        
        
        task.type = taskType
        task.color = taskColor
        task.deadline = taskDedline
        task.isCompleted = false
        task.title = taskTitle
        
        
        
        if let _ = try? contex.save(){
            
            return true
        }
        return false
        
        
    }
    
    func resetTask(){
        
        
        
        taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDedline = Date()
        editTask = nil
    }
    
    func setUpTask(){
        
        if let editTask = editTask {
            
            
            taskType = editTask.type ?? "Basic"
            taskColor = editTask.color ?? "Yellow"
            taskTitle = editTask.title ??  ""
            taskDedline = editTask.deadline ??  Date()
            
        }
    }
    
    
    
}
