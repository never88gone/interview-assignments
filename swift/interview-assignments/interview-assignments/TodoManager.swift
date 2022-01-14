//
//  TodoManager.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI
import Combine

class TodoManager: NSObject, ObservableObject {
    
    static let shared = TodoManager()
    
    // Make sure the class has only one instance
    // Should not init or copy outside
    private override init() {}
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    
    // Optional
    func reset() {
        // Reset all properties to default value
    }

    
    
    @Published var todoGroups = [TodoGroup]()
    
    func addTask(info: String ,title: String) {
        var isContain : Bool = false
        var equalIndex : Int = 0
        var  countIndex: Int = 0
        for oneGroup in todoGroups {
            if (oneGroup.title == title){
                isContain = true
                equalIndex = countIndex
                break
                
            }
            countIndex += 1
        }
        if(isContain){
            var oneGroup=todoGroups[equalIndex]
            let oneTodo : Todo =  Todo(info: info,title: title,index: oneGroup.todos.count)
            oneGroup.todos.append(oneTodo)
            todoGroups[equalIndex]=oneGroup
        }else {
            let oneTodoGroup : TodoGroup =  TodoGroup(title: title,index: 0)
            todoGroups.append(oneTodoGroup)
        }
    }
}

struct Todo: Identifiable {
    var id:  UUID = UUID()
    var info: String
    var title: String = ""
    var hasDelete : Bool=false
    var isEdit : Bool=false
    var index:  Int=0
}

struct TodoGroup: Identifiable {
    var id:  UUID = UUID()
    var title: String = ""
    var index:  Int=0
    var todos = [Todo]()
}

