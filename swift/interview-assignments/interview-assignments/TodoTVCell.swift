//
//  ToDoTVCell.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/11.
//

import SwiftUI

struct TodoTVCell: View {
    @FocusState var isNameFocused:Bool
    @State  var todo:Todo
    let cellTextChangedAction: ((String) -> Void)?
    let cellCheckedChangedAction: (() -> Void)?
    var body: some View {
        ZStack {
            HStack{
                Group {
                    if (todo.checked){
                        ZStack{
                            Image(systemName:"circle").resizable().frame(width: 30, height: 30).foregroundColor(Color("ngtextgray"))
                            Image(systemName: "circle.fill").resizable().frame(width: 15, height: 15).foregroundColor(Color("ngtextgray"))
                        }
                    }else {
                        Image(systemName: "circle").resizable().frame(width: 30, height: 30, alignment: .center).foregroundColor(Color("ngtextgray"))
                    }
                }.padding(.leading, 10.0).background(Color.clear).onTapGesture {
                    cellCheckedChangedAction?()
                }
                Group{
                    if (!todo.checked){
                        TextField("添加信息", text: $todo.title)
                            .foregroundColor(Color("ngtextback"))
                            .textFieldStyle(PlainTextFieldStyle())
                            .focused($isNameFocused)
                            .onSubmit {
                                isNameFocused = false
                                cellTextChangedAction?(todo.title)
                            }
                    }else {
                        Text(todo.title).strikethrough(true, color: Color("ngtextgray")).foregroundColor( Color("ngtextgray"))
                    }
                }.background(Color.clear).font(.custom("PingFangSC-Regular", size: 12).weight(.bold))
                Spacer()
            }
            if (todo.checked){
                ZStack{
                    Rectangle().frame(width: .infinity, height: 1, alignment:.center).padding().foregroundColor(Color("ngtextgraybackgroud"))
                    
                }.frame(maxWidth: .infinity,maxHeight: .infinity).background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1)).allowsHitTesting(false)
            }
        }.frame(minHeight:40,maxHeight: .infinity).background(Color.white).cornerRadius(10.0).padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing:5))      .gesture(LongPressGesture().onEnded { aaa in
            isNameFocused = true
        })
    }
}


struct ToDoTVCell_Previews: PreviewProvider {
    static var previews: some View {
        let todo = Todo(title: "info", groupName: "haha")
        return TodoTVCell(todo:todo, cellTextChangedAction: {
            inputText in
            if (inputText.count == 0) {
                
            }
        }, cellCheckedChangedAction:{
            todo.checked.toggle()
        }).previewLayout(.fixed(width: 375, height: 50))
        
    }
}
