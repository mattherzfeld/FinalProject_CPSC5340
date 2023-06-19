//
//  TaskViewModel.swift
//  TaskTracker
//
//  Created by user239896 on 6/17/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class TaskViewModel : ObservableObject {
    
    @Published var tasks = [TaskModel]()
    let db = Firestore.firestore()
    
        
    func fetchData() {
        self.tasks.removeAll()
        db.collection("tasks")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.tasks.append(try document.data(as: TaskModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
        }
    }
    
    func saveData(task: TaskModel) {
        if let id = task.id {
            // Edit task
            if !task.title.isEmpty || !task.taskdata.isEmpty {
                let docRef = db.collection("tasks").document(id)
                docRef.updateData([
                    "title": task.title,
                    "taskdata" : task.taskdata
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        } else {
            // Add Task
            if !task.title.isEmpty || !task.taskdata.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("tasks").addDocument(data: [
                    "title": task.title,
                    "taskdata": task.taskdata
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
                
            }
        }
    }
}
