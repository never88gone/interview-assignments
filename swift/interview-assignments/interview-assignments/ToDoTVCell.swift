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
                Image(systemName: todo.hasDelete ? "circle.fill" : "circle").resizable().frame(width: 50, height: 50, alignment: .center).padding(.leading, 10.0).background(Color.clear)
                
                TextField("添加信息", text: $todo.info)
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color.clear).font(.title).foregroundColor(.white)
            }
            if (todo.hasDelete){
                ZStack{
                    
                }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(Color.clear)
            }else {
   
            }

        }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(Color.red).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5)).cornerRadius(5.0)
    }
}

struct ToDoTVCell_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(info: "todoTest1")
        return ToDoTVCell(todo: todoManager.todos[0])
            .previewLayout(.sizeThatFits).frame(width: 375, height: 100, alignment: .center)
    }
}
