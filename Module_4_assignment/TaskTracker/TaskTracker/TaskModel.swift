//
//  TaskModel.swift
//  TaskTracker
//
//  Created by user239896 on 6/17/23.
//

import Foundation
import FirebaseFirestoreSwift

struct TaskModel : Codable, Identifiable {
    @DocumentID var id : String?
    var title : String
    var taskdata : String
    
}
