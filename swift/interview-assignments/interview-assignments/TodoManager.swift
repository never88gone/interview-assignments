//
//  TodoManager.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI
import Combine

class TodoManager: NSObject, ObservableObject {

    //这里做了做list的拖动与删除增加的对象
    @Published var todos = [Todo]()
    
    //这里为了分组显示添加的逻辑
    @Published var todoGroups = [TodoGroup]()
    
    func addTask(title: String ,groupName: String, id:UUID = UUID(),hasDelete:Bool=false, disable:Bool=false) {
        var isContain : Bool = false
        var equalIndex : Int = 0
        var countIndex: Int = 0
        for oneGroup in todoGroups {
            if (oneGroup.groupName == groupName){
                isContain = true
                equalIndex = countIndex
                break
            }
            countIndex += 1
        }
        if(isContain){
            var oneGroup=todoGroups[equalIndex]
            let oneTodo : Todo =  Todo(title: title,groupName: groupName,hasDelete:hasDelete, disable:disable, index: oneGroup.todos.count)
            oneGroup.todos.append(oneTodo)
            todoGroups[equalIndex]=oneGroup
        }else {
            var oneTodoGroup : TodoGroup =  TodoGroup(groupName: groupName,index:todoGroups.count)
            let oneTodo : Todo =  Todo(title: title,groupName: groupName,hasDelete:hasDelete, disable:disable, index:0)
            oneTodoGroup.todos.append(oneTodo)
            todoGroups.append(oneTodoGroup)
        }
    }
    //获取整体列表，
    func sortTodoList(){
        todoGroups.sort(by: {return $0.index < $1.index})
        for oneIndex in todoGroups.indices {
            var oneGroup=todoGroups[oneIndex]
            oneGroup.todos.sort(by: {return $0.index < $1.index})
            todoGroups[oneIndex]=oneGroup
        }
        todos = [Todo]()
        for oneGroup in todoGroups {
            for oneTodo in oneGroup.todos {
                todos.append(oneTodo)
            }
        }
    }
    
    //获取整体列表，
    func groupTodoGroup(){
        todoGroups = [TodoGroup]()
        for oneTodo in todos {
            self.addTask(title: oneTodo.title, groupName: oneTodo.groupName,id:oneTodo.id,hasDelete:oneTodo.hasDelete, disable: oneTodo.disable)
        }
    }
    
}

struct Todo: Identifiable {
    var id:  UUID = UUID()
    var title: String
    var groupName: String = ""
    var hasDelete : Bool=false
    var disable : Bool=true
    var index:  Int=0
}

struct TodoGroup: Identifiable {
    var id:  UUID = UUID()
    var groupName: String = ""
    var index:  Int=0
    var todos = [Todo]()
}

