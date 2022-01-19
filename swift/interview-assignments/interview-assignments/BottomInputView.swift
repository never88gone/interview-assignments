//
//  BottomInputView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/11.
//

import SwiftUI

struct BottomInputView: View {
    @State  var todoList : [Todo]
    @State  var todo:Todo = Todo(title: "",groupName :"")
    @State private var inputTipText = ""
    @State private var  showingActionSheet=false
    @State private var  defualtTypeStr = ""
    let appendTodoAction: ((String,String) -> Void)?
    
    var body: some View {
        var groupDic : [String : [Todo]]{
           Dictionary (
            grouping: todoList,
               by: {$0.groupName}
           )
       }
        if(groupDic.keys.sorted().count>0){
            self.defualtTypeStr=groupDic.keys.sorted()[0]
        }
        var  buttons=[Alert.Button]()
        
        for oneTodoGroup in groupDic.keys.sorted() {
            let button = ActionSheet.Button.default(Text(oneTodoGroup),action: {
                self.defualtTypeStr=oneTodoGroup
            })
            buttons.append(button)
        }
        let cancelButton = ActionSheet.Button.default(Text("cancel"))
        buttons.append(cancelButton)
        
        return HStack {
            TextField("add new...", text:$inputTipText ).frame(width: .infinity, height: 44).padding(EdgeInsets(top:0, leading:10, bottom: 0, trailing: 5)).background(Color.white).cornerRadius(10).fixedSize(horizontal: false, vertical: true).foregroundColor(Color("ngtextback")).padding(EdgeInsets(top:5, leading:10, bottom: 5, trailing: 10)).onSubmit {
                appendTodoAction?(self.inputTipText,self.defualtTypeStr)
            }
                
            if (groupDic.keys.sorted().count>=0){
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

//struct BottomInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        let todoList = [Todo(title: "title1",groupName:"haha"), Todo(title: "title2",groupName:"haha"), Todo(title: "title13",groupName:"haha"), Todo(title: "title4",groupName:"haha1")]
////        let todoManager: TodoManager = TodoManager()
//        return BottomInputView(todoList: todoList, todo:todoList[0]).previewLayout(.fixed(width: 375, height: 60))
//    }
//}
