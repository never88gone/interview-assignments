//
//  ContentView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI


import SwiftUI

struct ContentView: View {
    @State  var  curGroupName : String = ""
    @State var todoManager: TodoManager = TodoManager()
    @State var todoList = [Todo(title: "Building Lists and Navigation",groupName:"SwiftUI Essentials"), Todo(title: "Creating and Combining Views",groupName:"SwiftUI Essentials"), Todo(title: "Hanline User Input",groupName:"SwiftUI Essentials"), Todo(title: "Animating Views and Transitions",groupName:"Drawing and Animation"), Todo(title: "Drawing Paths and Shapes",groupName:"Drawing and Animation")]
    
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
        let groupNameList = groupDic.keys.sorted()
        if(groupNameList.count>0){
            self.curGroupName=groupNameList[0]
        }
        return  NavigationView{
            VStack {
                List {
                    ForEach(groupDic.keys.sorted(), id: \.self ) { oneKey in
                        TodoSectionView(groupName: oneKey, sectionTodoList: groupDic[oneKey] ?? [] ,sectionCellTextChangedAction: { oneTodo, inputText in
                            if (inputText.count == 0) {
                                let curIndex = indexOfTodo(todo: oneTodo)
                                todoList.remove(at: curIndex)
                            }
                        }, sectionCellCheckedChangedAction: {
                            oneTodo in
                                let curIndex = indexOfTodo(todo: oneTodo)
                                todoList[curIndex]=oneTodo
                        })
                    }

                }.listStyle(GroupedListStyle()).background(Color.blue)
                Spacer()
                BottomInputView(groupNameList: groupNameList, groupName: $curGroupName, appendTodoAction : {
                    oneTitle, oneGroupName in
                        todoList.append(Todo(title: oneTitle, groupName: oneGroupName))
                     }
                    )
            }.navigationTitle(Text("List").font(.largeTitle).foregroundColor(Color("ngtextgraybackgroud")))
                .background(Color("ngmainbackgroud")).navigationBarItems(trailing: Button("添加分组", action: {
                    
                }))
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView().previewDevice("iPhone 13")
    }
}
