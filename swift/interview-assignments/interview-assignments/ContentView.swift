//
//  ContentView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI


import SwiftUI

struct ContentView: View {
    
    @State  private  var  showAlert : Bool = false
    @State private var  curGroupName : String = ""
    @State private var  curSearchTxt : String = ""
    @StateObject var todoManager: TodoManager = TodoManager()
    private  let navTile : String = "List"
    init(){
        UITableView.appearance().separatorColor = UIColor.clear
    }
    
    
    var body: some View {
        
        return  NavigationView{
            VStack {
                List {
                    ForEach(self.todoManager.groupNameList, id: \.self ) { oneKey in
                        let sectionTodoList = self.todoManager.groupDic[oneKey] ?? []
                        let sectionSortedTodos = sectionTodoList.sorted{ return  $0.checked != true ||  $1.checked == true
                        }
                        TodoSectionView(groupName: oneKey, sectionTodoList: sectionSortedTodos, sectionCellTextChangedAction: { oneTodo, inputText in
                            if (inputText.count == 0) {
                                withAnimation(.spring()) {
                                    let curIndex = self.todoManager.indexOfTodo(todo: oneTodo)
                                    self.todoManager.removeTodo(index: curIndex)
                                }
                            }
                        }, sectionCellCheckedChangedAction: {
                            oneTodo in
                            withAnimation(.spring()) {
                                let curIndex = self.todoManager.indexOfTodo(todo: oneTodo)
                                self.todoManager.updateTodo(index: curIndex, todo: oneTodo)
                            }
                        })
                    }
                }.listStyle(GroupedListStyle())
                Spacer()
                BottomInputView(groupNameList: self.todoManager.groupNameList, groupName: $todoManager.curGroupName, appendTodoAction : {
                    oneTitle, oneGroupName in
                    withAnimation(.spring()) {
                        self.todoManager.addTodo(todo: Todo(title: oneTitle, groupName: oneGroupName))
                    }
                }
                )
            }.background(Color("ngmainbackgroud")).navigationBarTitleDisplayMode(.large).navigationTitle(Text(self.navTile)).navigationBarItems(trailing : SearchBar(text: $curSearchTxt, searchTextChangedAction: {
                searchText in
                self.todoManager.searchText = self.curSearchTxt

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
