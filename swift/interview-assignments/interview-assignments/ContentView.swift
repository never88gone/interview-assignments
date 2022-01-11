//
//  ContentView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI


import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @State private var todoStr = ""
    @State private var descStr = "aaa"

    @EnvironmentObject private var todoManager: TodoManager
    
    func deleteRow(at offsets:IndexSet) {
        todoManager.todos.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView{
            VStack {

                List(todoManager.todos) { todo in ToDoTVCell(todo: todo)
                    
                }.onDelete(perform: removeRows)
                
                BottomInputView(todo: todoManager.curTodo)
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
            .navigationTitle(Text("List").font(.largeTitle))
            .background(Color(.init(red: 0xf7/255, green: 0xf7/255, blue: 0xf7/255, alpha: 0)))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(info: "desc1")
        todoManager.addTask(info: "desc2")
        todoManager.addTask(info: "desc2")
        todoManager.addTask(info: "desc2")
        todoManager.addTask(info: "desc2")
        todoManager.addTask(info: "desc2")
        todoManager.curTodo=todoManager.todos[0]
        return ContentView().previewDevice("iPhone 13").environmentObject(todoManager)
    }
}
