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
                                let curIndex = todoManager.indexOfTodo(todo: oneTodo)
                                todoManager.removeTodo(index: curIndex)
                                todoManager.calcTodoGroup(text: self.curSearchTxt)
                            }
                        }, sectionCellCheckedChangedAction: {
                            oneTodo in
                            let curIndex = todoManager.indexOfTodo(todo: oneTodo)
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
            }.navigationBarTitleDisplayMode(.large).navigationTitle(Text("List")).navigationBarItems(trailing : SearchBar(text: $curSearchTxt, searchTextChangedAction: {
                searchText in
                todoManager.calcTodoGroup(text: self.curSearchTxt)
            }).frame(width:150, height: 44).overlay(RoundedRectangle(cornerRadius: 15).stroke().fill(Color.blue)))
                .navigationBarItems(leading: Button(action: {
                    withAnimation(Animation.easeInOut(duration: 1)) {
                        self.showAlert.toggle()
                    }
                }){
                    Image(systemName:"rectangle.stack.badge.plus").resizable().frame(width: 30, height: 30).foregroundColor(Color.blue)
                    
                })
        }.edgesIgnoringSafeArea(.all).textFieldAlert(isShowing: $showAlert, text: $todoManager.curGroupName)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView().previewDevice("iPhone 13")
    }
}
