//
//  TodoDetail.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI

struct TodoDetail: View {
    @EnvironmentObject var todoManager: TodoManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var todo: Todo
    
    var todoIndex: Int {
        todoManager.todos.firstIndex(where: { $0.id == todo.id })!
    }
    
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            VStack {
                Text("TODO Detail")
                TextField("输入任务", text: $todo.info)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                    self.todoManager.todos[self.todoIndex] = self.todo
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Update")
                }
            }
        }
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(info: "todoTest")
        return TodoDetail(todo: todoManager.todos[0])
            .environmentObject(todoManager)
    }
}
