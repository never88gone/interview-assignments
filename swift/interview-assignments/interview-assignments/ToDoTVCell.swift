//
//  ToDoTVCell.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/11.
//

import SwiftUI

struct ToDoTVCell: View {
    @State  var todo:Todo
    var body: some View {
        ZStack {
            HStack{
                Image(systemName: todo.hasDelete ? "circle.fill" : "circle").resizable().frame(width: 40, height: 40, alignment: .center).padding(.leading, 10.0).background(Color.clear)
                
                TextField("添加信息", text: $todo.info)
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color.clear).font(.title).foregroundColor(.black)
            }
            if (todo.hasDelete){
                ZStack{
                    Rectangle().frame(width: .infinity, height: 1, alignment:.center).foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 1)).padding()

                }.frame(maxWidth: .infinity,maxHeight: .infinity).background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.3))
            }else {
   
            }

        }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(Color.clear).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 100)).cornerRadius(5.0)
    }
}

struct ToDoTVCell_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(info: "todoTest1")
        todoManager.todos[0].hasDelete=true
        return ToDoTVCell(todo: todoManager.todos[0]).previewLayout(.fixed(width: 375, height: 60)).environmentObject(todoManager)
            
    }
}
