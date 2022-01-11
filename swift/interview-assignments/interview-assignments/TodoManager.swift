//
//  TodoManager.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI
import Combine

class TodoManager: NSObject, ObservableObject {
    @Published  var curTodo: Todo=Todo(info: "")
    @Published var todos = [Todo]()
    
    func addTask(info: String) {
        todos.append(Todo(info: info))
    }
}

struct Todo: Identifiable {
    var id:  UUID = UUID()
    var info: String
    var hasDelete : Bool=false
}


