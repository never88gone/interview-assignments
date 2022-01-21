//
//  ContentView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI


import SwiftUI

struct ContentView: View {
    
    @State  var  showAlert : Bool = false
    @State  var  curGroupName : String = ""
    @StateObject var todoManager: TodoManager = TodoManager()
    
    init(){
        UITableView.appearance().separatorColor = UIColor.clear
        
    }
    func indexOfTodo(todo: Todo) -> Int {
        var oneIndex : Int = 0
        for oneTodo in todoManager.todoList {
            if ( oneTodo.id == todo.id)
            {
               break
            }
            oneIndex = oneIndex + 1
        }
        return oneIndex
    }
    var body: some View {
        
        return  NavigationView{
            VStack {
                List {
                    ForEach(todoManager.groupNameList, id: \.self ) { oneKey in
                        
                        let sectionTodoList = todoManager.groupDic[oneKey] ?? []
                        let sectionSortedTodos = sectionTodoList.sorted{ return  $0.checked != true ||  $1.checked == true
                        }
                        TodoSectionView(groupName: oneKey, sectionTodoList: sectionSortedTodos, sectionCellTextChangedAction: { oneTodo, inputText in
                            if (inputText.count == 0) {
                                let curIndex = indexOfTodo(todo: oneTodo)
                                var tempList =  todoManager.todoList
                                tempList.remove(at: curIndex)
                                todoManager.todoList = tempList
                                todoManager.calcTodoGroup()
                            }
                        }, sectionCellCheckedChangedAction: {
                            oneTodo in
                                let curIndex = indexOfTodo(todo: oneTodo)
                            todoManager.todoList[curIndex]=oneTodo
                            todoManager.calcTodoGroup()
                        })

                        
                    }
                }.listStyle(GroupedListStyle()).background(Color.blue)
                Spacer()
                BottomInputView(groupNameList: todoManager.groupNameList, groupName: $todoManager.curGroupName, appendTodoAction : {
                    oneTitle, oneGroupName in
                        var tempList =  todoManager.todoList
                        tempList.append(Todo(title: oneTitle, groupName: oneGroupName))
                        todoManager.todoList = tempList
                        todoManager.calcTodoGroup()
                     }
                    )
            }.navigationTitle(Text("List").font(.largeTitle).foregroundColor(Color("ngtextgraybackgroud")))
                .background(Color("ngmainbackgroud")).navigationBarItems(trailing: Button("添加分组", action: {
                    self.showAlert.toggle()
                }))
        }.edgesIgnoringSafeArea(.all).textFieldAlert(isShowing: $showAlert, text: $todoManager.curGroupName, placeholder: "添加分组名称", title: "设置当前分组名称")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView().previewDevice("iPhone 13")
    }
}
