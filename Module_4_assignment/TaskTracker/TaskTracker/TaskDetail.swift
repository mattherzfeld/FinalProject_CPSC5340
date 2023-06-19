//
//  TaskDetail.swift
//  TaskTracker
//
//  Created by user239896 on 6/17/23.
//

import SwiftUI

struct TaskDetail: View {
    
    @Binding var task : TaskModel
    @StateObject var taskApp = TaskViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Task Title", text: $task.title)
                .font(.system(size: 25))
                .fontWeight(.bold)
            TextEditor(text: $task.taskdata)
                .font(.system(size: 20))
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    taskApp.saveData(task: task)
                    task.title = ""
                    task.taskdata = ""
                } label: {
                    Text("Save")
                }
            }
            ToolbarItem(placement: .navigationBarLeading){
                Button {
                    task.title = ""
                    task.taskdata = ""
                } label: {
                    Text("Delete")
                }
            }
        }
    }
}

struct TaskDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: .constant(TaskModel(title: "#1", taskdata: "1st Task")))
    }
}
