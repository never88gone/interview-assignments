//
//  TodoManager.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI
import Combine

class TodoManager: ObservableObject {
    private let cacheFileName : String = "data"
    private var todoList: [Todo] = [Todo]()
    @Published var showTodoList: [Todo] = [Todo]()
    @Published var groupDic : [String : [Todo]] = [String : [Todo]]()
    @Published var groupNameList : [String] = [String]()
    @Published var curGroupName : String = ""
    
    init() {
        readFromFile()
        showTodoList = todoList
        initCalcTodoGroup()
    }
    func initCalcTodoGroup(){
        groupDic = Dictionary (
            grouping: showTodoList,
            by: {$0.groupName}
        )
        groupNameList = groupDic.keys.sorted()
        if(groupNameList.count>0){
            curGroupName=groupNameList[0]
        }
    }
    
    func calcTodoGroup(text: String){
        if text.count > 0 {
            showTodoList = todoList.filter { (todo) -> Bool in
                return todo.title.lowercased().contains(text.lowercased())
            }
        }else {
            showTodoList = todoList
        }
        
        
        groupDic = Dictionary (
            grouping: showTodoList,
            by: {$0.groupName}
        )
        groupNameList = groupDic.keys.sorted()
    }
    func addTodo(todo:Todo){
        todoList.append(todo)
        save()
    }
    
    func removeTodo(index:Int){
        todoList.remove(at: index)
        save()
    }
    func updateTodo(index:Int , todo:Todo){
        todoList[index] = todo
        save()
    }
    func indexOfTodo(todo: Todo) -> Int {
        var oneIndex : Int = 0
        for oneTodo in todoList {
            if ( oneTodo.id == todo.id)
            {
                break
            }
            oneIndex = oneIndex + 1
        }
        return oneIndex
    }
    
    func save(){
        do {
            let jsonData = try JSONEncoder().encode(todoList)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            UserDefaults.standard.set(jsonString, forKey: cacheFileName)
            UserDefaults.standard.synchronize()
        } catch {
            print(error)
        }
    }
    func readFromFile(){
        do {
            if let jsonStr = UserDefaults.standard.string(forKey: cacheFileName) {
                if let  jsonData : Data = jsonStr.data(using: .utf8) {
                    if let decodedSentences = try JSONDecoder().decode([Todo]?.self, from: jsonData) {
                        todoList = decodedSentences
                        print(decodedSentences)
                        return
                    }
                }
            }
        } catch {
            print(error)
        }
        todoList = [Todo(title: "Building Lists and Navigation",groupName:"SwiftUI Essentials"), Todo(title: "Creating and Combining Views",groupName:"SwiftUI Essentials"), Todo(title: "Hanline User Input",groupName:"SwiftUI Essentials"), Todo(title: "Animating Views and Transitions",groupName:"Drawing and Animation"), Todo(title: "Drawing Paths and Shapes",groupName:"Drawing and Animation")]
    }
}

class Todo: Identifiable ,ObservableObject,Codable {
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
