//
//  ContentView.swift
//  TaskTracker
//
//  Created by user239896 on 6/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var taskApp = TaskViewModel()
    @State var task = TaskModel(title: "", taskdata: "")
    // @State
    // @ObservedObject
    // @StateObject
    
    var body: some View {
        NavigationStack {
            List {
                    ForEach($taskApp.tasks) { $task in
                        NavigationLink {
                            TaskDetail(task: $task)
                        } label : {
                            Text(task.title)
                        }
                    }
    
                Section {
                    NavigationLink {
                        TaskDetail(task: $task)
                    } label : {
                        Text("New Item")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15))
                    }
                    
                }
            }
            .onAppear {
                taskApp.fetchData()
            }
            .refreshable {
                taskApp.fetchData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
