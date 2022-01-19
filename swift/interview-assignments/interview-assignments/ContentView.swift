//
//  ContentView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI


import SwiftUI

struct ContentView: View {
    
    @State var todoManager: TodoManager = TodoManager()
    @State var todoList = [Todo(title: "title1",groupName:"haha"), Todo(title: "title2",groupName:"haha"), Todo(title: "title13",groupName:"haha"), Todo(title: "title4",groupName:"haha1")]
    
    init(){
        UITableView.appearance().separatorColor = UIColor.clear

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
    var body: some View {
        var groupDic : [String : [Todo]]{
           Dictionary (
            grouping: todoList,
               by: {$0.groupName}
           )
       }
        return  NavigationView{
            VStack {
                List {
                    ForEach(groupDic.keys.sorted(), id: \.self ) { oneKey in
                        Section(header: Text(oneKey).font(.title).foregroundColor(Color("ngtextback")))
                        {
                            let sectionTodos : [Todo] = groupDic[oneKey] ?? []
                            ForEach(sectionTodos) { oneTodo in
                                ToDoTVCell(todo:oneTodo, cellTextChangedAction: {
                                    inputText in
                                    if (inputText.count == 0) {
                                        let curIndex = indexOfTodo(todo: oneTodo)
                                        todoList.remove(at: curIndex)
                                    }
                                })
                            }
                            .listRowBackground(Color.clear)
                        }
                    }

                }.listStyle(GroupedListStyle()).background(Color.blue)
                Spacer()
                
                BottomInputView(todoList: todoList, appendTodoAction : {
                    oneTitle, oneGroupName in
                    todoList.append(Todo(title: oneTitle, groupName: oneGroupName))
                     }
                    )
            }.navigationTitle(Text("List").font(.largeTitle).foregroundColor(Color("ngtextgraybackgroud")))
                .background(Color("ngmainbackgroud"))
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView().previewDevice("iPhone 13")
    }
}
