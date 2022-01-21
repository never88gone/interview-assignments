//
//  TodoManager.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI
import Combine

class TodoManager: ObservableObject {
    @Published var todoList: [Todo] = [Todo]()
    @Published var groupDic : [String : [Todo]] = [String : [Todo]]()
    @Published var groupNameList : [String] = [String]()
    @Published var curGroupName : String = ""
    init() {
        todoList = [Todo(title: "Building Lists and Navigation",groupName:"SwiftUI Essentials"), Todo(title: "Creating and Combining Views",groupName:"SwiftUI Essentials"), Todo(title: "Hanline User Input",groupName:"SwiftUI Essentials"), Todo(title: "Animating Views and Transitions",groupName:"Drawing and Animation"), Todo(title: "Drawing Paths and Shapes",groupName:"Drawing and Animation")]
        initCalcTodoGroup()
    }
    func initCalcTodoGroup(){
        groupDic = Dictionary (
                    grouping: todoList,
                       by: {$0.groupName}
                   )
        groupNameList = groupDic.keys.sorted()
        if(groupNameList.count>0){
            curGroupName=groupNameList[0]
        }
    }
    
    func calcTodoGroup(){
        groupDic = Dictionary (
                    grouping: todoList,
                       by: {$0.groupName}
                   )
        groupNameList = groupDic.keys.sorted()
    }
//    func addTodo(todo:Todo){
//        objectWillChange.send()
//        todoList.append(todo)
//        calcTodoGroup()
//    }
//
//    func removeTodo(index:Int){
//        objectWillChange.send()
//        todoList.remove(at: index)
//        calcTodoGroup()
//    }
    
}

class Todo: Identifiable ,ObservableObject {
    var id:  UUID = UUID()
    var title: String = ""
    var groupName: String = ""
    var checked : Bool=false
    var disable : Bool=true
    private  init() {
    }
    public  init(title: String,groupName: String = "") {
        self.title=title
        self.groupName=groupName
    }
}
