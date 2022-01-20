//
//  BottomInputView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/11.
//

import SwiftUI

struct BottomInputView: View {
    @State  var groupNameList : [String]
    @Binding  var  groupName : String
    @State private var inputTipText = ""
    @State private var  showingActionSheet = false
   
    let appendTodoAction: ((String,String) -> Void)?
   
    var body: some View {
        var  buttons=[Alert.Button]()
        for oneTodoGroup in groupNameList {
            let button = ActionSheet.Button.default(Text(oneTodoGroup),action: {
                self.groupName=oneTodoGroup
            })
            buttons.append(button)
        }
        let cancelButton = ActionSheet.Button.default(Text("cancel"))
        buttons.append(cancelButton)
        
        return HStack {
            TextField("add new...", text:$inputTipText ).frame(width: .infinity, height: 44).padding(EdgeInsets(top:0, leading:10, bottom: 0, trailing: 5)).background(Color.white).cornerRadius(10).fixedSize(horizontal: false, vertical: true).foregroundColor(Color("ngtextback")).padding(EdgeInsets(top:5, leading:10, bottom: 5, trailing: 10)).onSubmit {
                appendTodoAction?(self.inputTipText,self.groupName)
            }
                
            if (groupNameList.count>=0){
                Button(action: {
                    self.showingActionSheet = true
                }){
                    HStack{
                        Text(self.groupName).fixedSize(horizontal: false, vertical: true).foregroundColor(Color("ngtextback")).font(.system(size: 12))

                        Image(systemName: "chevron.down").foregroundColor(Color("ngtextgray")).padding(.trailing,5).frame(width: 20, height: 20)
                    }.frame(maxHeight: .infinity).cornerRadius(10)
                }.frame(minWidth:50 ,maxWidth: 120, maxHeight: 32).background(Color.white).cornerRadius(10).padding(EdgeInsets(top:5, leading:0, bottom: 5, trailing: 5)).layoutPriority(1).actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("选择类型"), message: Text("选择todo的类型"), buttons: buttons
                    )
                }
            }
        }.background(Color("ngmainbackgroud"))
    }
}

struct BottomInputView_Previews: PreviewProvider {
    @State static var groupName = "分组"
    static var previews: some View {
        let groupNameList = ["SwiftUI Essentials","Drawing and Animation"]
      
        return BottomInputView(groupNameList: groupNameList,groupName : $groupName, appendTodoAction : {
            oneTitle, oneGroupName in

             }).previewLayout(.fixed(width: 375, height: 60))
    }
}
