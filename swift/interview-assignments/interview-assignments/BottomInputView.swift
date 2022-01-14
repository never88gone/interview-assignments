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
    @State private var  showingActionSheet=false
    @State private var  defualtTypeStr = ""
    var body: some View {
        let sectionList = [String](todoManager.getShowTodos().keys)
        if(sectionList.count>0){
            self.defualtTypeStr=sectionList[0]
        }
        var  buttons=[Alert.Button]()
        
        for oneSection in sectionList {
            let button = ActionSheet.Button.default(Text(oneSection),action: {
                self.defualtTypeStr=oneSection
            })
            buttons.append(button)
        }
        let cancelButton = ActionSheet.Button.default(Text("cancel"))
        buttons.append(cancelButton)
        
        return HStack {
            TextEditor(text: $inputTipText).background(Color.white).frame(maxWidth: .infinity, maxHeight: 44).fixedSize(horizontal: false, vertical: true).foregroundColor(Color("ngtextback")).padding(EdgeInsets(top:5, leading:10, bottom: 5, trailing: 5)).cornerRadius(10)
                
            if (sectionList.count>=0){
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
        let todoManager = TodoManager()
        todoManager.addTask(info: "todoTest1",title: "haha")
        todoManager.addTask(info: "todoTest1",title: "haha")
        todoManager.addTask(info: "todoTest1",title: "haha")
        return BottomInputView(todo: todoManager.todos[0]).environmentObject(todoManager).previewLayout(.fixed(width: 375, height: 60))
    }
}
