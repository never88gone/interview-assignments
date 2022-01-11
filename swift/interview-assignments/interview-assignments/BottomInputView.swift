//
//  BottomInputView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/11.
//

import SwiftUI

struct BottomInputView: View {
    @EnvironmentObject var todoManager: TodoManager
    @State  var todo:Todo
    @State private var inputTipText = "add new..."
    
    var body: some View {
        HStack {
            TextEditor(text: $inputTipText).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: 44, alignment: .bottom).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).cornerRadius(10).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Button(action: {
                todoManager.addTask(info: todo.info)
            }){
                Text("添加").frame(minWidth: 0, maxWidth: 100, minHeight: 0,  maxHeight: 44, alignment: .center).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).cornerRadius(10).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).cornerRadius(10).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
    }
}

struct BottomInputView_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(info: "todoTest1")
       return BottomInputView(todo: todoManager.todos[0]).previewLayout(.sizeThatFits).frame(width: 375, height: 100, alignment: .center)
    }
}
