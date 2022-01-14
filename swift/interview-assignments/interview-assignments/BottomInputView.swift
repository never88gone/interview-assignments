//
//  BottomInputView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/11.
//

import SwiftUI

struct BottomInputView: View {
    @State  var todo:Todo = Todo(info: "",title :"")
    @State private var inputTipText = "add new..."
    @State private var  showingActionSheet=false
    @State private var  defualtTypeStr = ""
    var body: some View {
        if(TodoManager.shared.todoGroups.count>0){
            self.defualtTypeStr=TodoManager.shared.todoGroups[0].title
        }
        var  buttons=[Alert.Button]()
        
        for oneTodoGroup in TodoManager.shared.todoGroups {
            let button = ActionSheet.Button.default(Text(oneTodoGroup.title),action: {
                self.defualtTypeStr=oneTodoGroup.title
            })
            buttons.append(button)
        }
        let cancelButton = ActionSheet.Button.default(Text("cancel"))
        buttons.append(cancelButton)
        
        return HStack {
            TextEditor(text: $inputTipText).background(Color.white).frame(maxWidth: .infinity, maxHeight: 44).fixedSize(horizontal: false, vertical: true).foregroundColor(Color("ngtextback")).padding(EdgeInsets(top:5, leading:10, bottom: 5, trailing: 5)).cornerRadius(10)
                
            if (TodoManager.shared.todoGroups.count>=0){
                Button(action: {
                    self.showingActionSheet = true
                }){
                    HStack{
                        Text(defualtTypeStr).foregroundColor(Color("ngtextback"))
                        Image(systemName: "chevron.down").foregroundColor(Color("ngtextgray"))
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).cornerRadius(10)
                }.frame(maxWidth: 100, maxHeight: 44).background(Color.white).cornerRadius(10).padding(EdgeInsets(top:5, leading:0, bottom: 5, trailing: 15)).actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("选择类型"), message: Text("选择todo的类型"), buttons: buttons
                    )
                }
            }
            
        }.background(Color("ngmainbackgroud"))
    }
}

struct BottomInputView_Previews: PreviewProvider {
    static var previews: some View {
        TodoManager.shared.addTask(info: "todoTest1",title: "haha")
        TodoManager.shared.addTask(info: "todoTest1",title: "haha")
        TodoManager.shared.addTask(info: "todoTest1",title: "haha")
        return BottomInputView(todo: TodoManager.shared.todoGroups[0].todos[0]).previewLayout(.fixed(width: 375, height: 60))
    }
}
