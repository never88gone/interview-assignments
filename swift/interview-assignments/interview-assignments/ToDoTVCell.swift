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
                            Image(systemName:"circle").resizable().frame(width: 30, height: 30).foregroundColor(Color("ngtextgray"))
                            Image(systemName: "circle.fill").resizable().frame(width: 15, height: 15).foregroundColor(Color("ngtextgray"))
                        }
                       
                    }else {
                        Image(systemName: "circle").resizable().frame(width: 30, height: 30, alignment: .center).foregroundColor(Color("ngtextgray"))
                    }
                }.padding(.leading, 10.0).background(Color.clear)
                Group{
                    if (todo.isEdit){
                        TextField("添加信息", text: $todo.info)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(!todo.hasDelete ? Color("ngtextback"): Color("ngtextgray")) .disabled(!todo.isEdit)
                    }else {
                        Text(todo.info).strikethrough(true, color: Color("ngtextgray")).foregroundColor( Color("ngtextgray"))
                    }
                }.background(Color.clear).font(.title)
                Spacer()
            }
            if (todo.hasDelete){
                ZStack{
                    Rectangle().frame(width: .infinity, height: 1, alignment:.center).padding().foregroundColor(Color("ngtextgraybackgroud"))

                }.frame(maxWidth: .infinity,maxHeight: .infinity).background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
            }

        }.frame(minHeight:40,maxHeight: .infinity).background(Color.white).cornerRadius(10.0).padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing:5))
    }
}

struct ToDoTVCell_Previews: PreviewProvider {
    static var previews: some View {
        TodoManager.shared.addTask(info: "info1",title: "title1")
        TodoManager.shared.addTask(info: "info2",title: "title1")
        TodoManager.shared.todoGroups[0].todos[0].isEdit=false
        TodoManager.shared.todoGroups[0].todos[0].hasDelete=false
        return ToDoTVCell(todo: TodoManager.shared.todoGroups[0].todos[0]).previewLayout(.fixed(width: 375, height: 50))
            
    }
}
