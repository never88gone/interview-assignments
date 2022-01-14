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
                Group {
                    if (todo.hasDelete){
                        ZStack{
                            Image(systemName:"circle").resizable().frame(width: 40, height: 40).foregroundColor(Color("ngtextgray"))
                            Image(systemName: "circle.fill").resizable().frame(width: 25, height: 25).foregroundColor(Color("ngtextgray"))
                        }
                       
                    }else {
                        Image(systemName: "circle").resizable().frame(width: 40, height: 40, alignment: .center).foregroundColor(Color("ngtextgray"))
                    }
                }.padding(.leading, 10.0).background(Color.clear)
                
                TextField("添加信息", text: $todo.info)
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color.clear).font(.title).foregroundColor(!todo.hasDelete ? Color("ngtextback"): Color("ngtextgray")) .disabled(!todo.isEdit)
            }
            if (todo.hasDelete){
                ZStack{
                    Rectangle().frame(width: .infinity, height: 1, alignment:.center).padding().foregroundColor(Color("ngtextgraybackgroud"))

                }.frame(maxWidth: .infinity,maxHeight: .infinity).background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
            }

        }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(Color.clear).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing:10)).cornerRadius(5.0)
    }
}

struct ToDoTVCell_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(info: "todoTest1")
        todoManager.todos[0].hasDelete=false
        return ToDoTVCell(todo: todoManager.todos[0]).previewLayout(.fixed(width: 375, height: 60)).environmentObject(todoManager)
            
    }
}
