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

    
    /**数据展示的时候使用**/
    func getShowTodos() -> Dictionary<String, [Todo]>{
        return Dictionary(grouping: todos, by: {
            $0.title
        })
    }
    func addTask(info: String) {
        todos.append(Todo(info: info))
    }
    func addTask(info: String ,title: String) {
        todos.append(Todo(info: info,title: title))
    }
}

struct Todo: Identifiable {
    var id:  UUID = UUID()
    var info: String
    var title: String = ""
    var hasDelete : Bool=false
    var isEdit : Bool=false
}

