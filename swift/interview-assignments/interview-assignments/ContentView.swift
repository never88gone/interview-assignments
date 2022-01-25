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
    @State  var  showSearch : Bool = false
    @State  var  curGroupName : String = ""
    @State  var  curSearchTxt : String = ""
    @StateObject var todoManager: TodoManager = TodoManager()
    
    init(){
        UITableView.appearance().separatorColor = UIColor.clear
        
    }
    func indexOfTodo(todo: Todo) -> Int {
        var oneIndex : Int = 0
        for oneTodo in todoManager.showTodoList {
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
                                todoManager.removeTodo(index: curIndex)
                                todoManager.calcTodoGroup(text: self.curSearchTxt)
                            }
                        }, sectionCellCheckedChangedAction: {
                            oneTodo in
                                let curIndex = indexOfTodo(todo: oneTodo)
                            todoManager.updateTodo(index: curIndex, todo: oneTodo)
                            todoManager.calcTodoGroup(text: self.curSearchTxt)
                        })

                        
                    }
                }.listStyle(GroupedListStyle()).background(Color.blue)
                Spacer()
                BottomInputView(groupNameList: todoManager.groupNameList, groupName: $todoManager.curGroupName, appendTodoAction : {
                    oneTitle, oneGroupName in
                        todoManager.addTodo(todo: Todo(title: oneTitle, groupName: oneGroupName))
                        todoManager.calcTodoGroup(text: self.curSearchTxt)

                     }
                    )
            }.navigationTitle(Text("List").font(.largeTitle).foregroundColor(Color("ngtextgraybackgroud")))
                .background(Color("ngmainbackgroud")).navigationBarItems(trailing : SearchBar(placeholder: "输入查询内容", text: $curSearchTxt, searchTextChangedAction: {
                    searchText in
                    todoManager.calcTodoGroup(text: self.curSearchTxt)
                }).frame(width:150, height: 44).overlay(RoundedRectangle(cornerRadius: 15).stroke().fill(Color.blue)))
                  .navigationBarItems(leading: Button(action: {
                    self.showAlert.toggle()
                }){
                    Image(systemName:"rectangle.stack.badge.plus").resizable().frame(width: 30, height: 30).foregroundColor(Color.blue)
                    
                })
        }.edgesIgnoringSafeArea(.all).textFieldAlert(isShowing: $showAlert, text: $todoManager.curGroupName, placeholder: "添加分组名称", title: "设置当前分组名称")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView().previewDevice("iPhone 13")
    }
}
