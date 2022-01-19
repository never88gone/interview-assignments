//
//  ToDoTVCell.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/11.
//

import SwiftUI

struct ToDoTVCell: View {
    @State  var todo:Todo
    let cellTextChangedAction: ((String) -> Void)?
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
                    if (!todo.hasDelete){
                        TextField("添加信息", text: $todo.title)
                            .foregroundColor(Color.red)
                            .textFieldStyle(PlainTextFieldStyle())
//                            .disabled(false)
                            .onSubmit {
                                cellTextChangedAction?(todo.title)
                            }
                    }else {
                        Text(todo.title).strikethrough(true, color: Color("ngtextgray")).foregroundColor( Color("ngtextgray"))
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
        let todo = Todo(title: "info", groupName: "haha")
        return ToDoTVCell(todo:todo, cellTextChangedAction: {
            inputText in
            if (inputText.count == 0) {
               
            }
        }).previewLayout(.fixed(width: 375, height: 50))

    }
}
