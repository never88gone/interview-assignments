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
        let sectionList = [String](todoManager.getShowTodos().keys)
       return HStack {
           TextEditor(text: $inputTipText).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: 44, alignment: .bottom).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).cornerRadius(10).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).padding()
           if (sectionList.count>=0){
               Button(action: {

               }){
                   HStack{
                       Text(sectionList[0]).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                       Image(systemName: "chevron.down")
                   }.frame(maxWidth: .infinity, maxHeight: .infinity).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).cornerRadius(10)
               }.frame(maxWidth: 100, maxHeight: 44).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).cornerRadius(10).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
           }

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
    }
}

struct BottomInputView_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(info: "todoTest1",title: "haha")
        todoManager.addTask(info: "todoTest1",title: "haha")
        todoManager.addTask(info: "todoTest1",title: "haha")
        return BottomInputView(todo: todoManager.todos[0]).environmentObject(todoManager).previewLayout(.fixed(width: 375, height: 60))
    }
}
