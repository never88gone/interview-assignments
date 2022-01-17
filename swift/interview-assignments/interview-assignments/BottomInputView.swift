//
//  BottomInputView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/11.
//

import SwiftUI

struct BottomInputView: View {
    @EnvironmentObject var todoManager: TodoManager
    
    @State  var todo:Todo = Todo(title: "",groupName :"")
    @State private var inputTipText = ""
    @State private var  showingActionSheet=false
    @State private var  defualtTypeStr = ""
    var body: some View {
        if(todoManager.todoGroups.count>0){
            self.defualtTypeStr=todoManager.todoGroups[0].groupName
        }
        var  buttons=[Alert.Button]()
        
        for oneTodoGroup in todoManager.todoGroups {
            let button = ActionSheet.Button.default(Text(oneTodoGroup.groupName),action: {
                self.defualtTypeStr=oneTodoGroup.groupName
            })
            buttons.append(button)
        }
        let cancelButton = ActionSheet.Button.default(Text("cancel"))
        buttons.append(cancelButton)
        
        return HStack {
            TextField("add new...", text:$inputTipText ).frame(width: .infinity, height: 44).padding(EdgeInsets(top:0, leading:10, bottom: 0, trailing: 5)).background(Color.white).cornerRadius(10).fixedSize(horizontal: false, vertical: true).foregroundColor(Color("ngtextback")).padding(EdgeInsets(top:5, leading:10, bottom: 5, trailing: 10)).onSubmit {
                todoManager.addTask(title: self.inputTipText,groupName:self.defualtTypeStr)
            }
                
            if (todoManager.todoGroups.count>=0){
                Button(action: {
                    self.showingActionSheet = true
                }){
                    HStack{
                        Text(defualtTypeStr).foregroundColor(Color("ngtextback"))
                        Spacer()
                        Image(systemName: "chevron.down").foregroundColor(Color("ngtextgray")).padding(.trailing,5)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).cornerRadius(10)
                }.frame(minWidth: 50,maxWidth: 80, maxHeight: 30).background(Color.white).cornerRadius(10).padding(EdgeInsets(top:5, leading:0, bottom: 5, trailing: 15)).layoutPriority(1).actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("选择类型"), message: Text("选择todo的类型"), buttons: buttons
                    )
                }
            }
            
        }.background(Color("ngmainbackgroud"))
    }
}

struct BottomInputView_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(title: "desc1",groupName: "haha" )
        todoManager.addTask(title: "desc2",groupName: "haha" )
        todoManager.addTask(title: "desc3",groupName: "haha1" )
        todoManager.addTask(title: "desc4",groupName: "haha1" )
        todoManager.addTask(title: "desc5",groupName: "haha1" )
        todoManager.addTask(title: "desc6",groupName: "haha1" )
        return BottomInputView(todo: todoManager.todoGroups[0].todos[0]).previewLayout(.fixed(width: 375, height: 60)).environmentObject(todoManager)
    }
}
