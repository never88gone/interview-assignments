//
//  ContentView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI


import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @State private var todoStr = ""
    @State private var descStr = "aaa"

    
    func deleteRow(at offsets:IndexSet) {
       
    }
    func moveItem(from source: IndexSet, to destination: Int) {
      
    }
    init(){
        TodoManager.shared.addTask(info: "desc1",title: "haha" )
        TodoManager.shared.addTask(info: "desc2",title: "haha" )
        TodoManager.shared.addTask(info: "desc3",title: "haha1" )
        TodoManager.shared.addTask(info: "desc4",title: "haha1" )
        TodoManager.shared.addTask(info: "desc5",title: "haha1" )
        TodoManager.shared.addTask(info: "desc6",title: "haha2" )
    }
    var body: some View {
        return  NavigationView{
            VStack {
                List {
                    ForEach(TodoManager.shared.todoGroups) { oneTodoGroup in
                        Section(header: Text(oneTodoGroup.title).font(.title).foregroundColor(Color("ngtextback")))
                        {
                            let todolist = oneTodoGroup.todos
                            ForEach(todolist) { oneTodo in
                                ToDoTVCell(todo:oneTodo)
                            }.onDelete(perform: deleteRow).onMove(perform: moveItem)
                            .listRowBackground(Color.clear)
                        }
                    }

                }.listStyle(GroupedListStyle()).background(Color.blue)
                Spacer()
                
                BottomInputView().layoutPriority(1)

            }.navigationTitle(Text("List").font(.largeTitle))
                .background(Color("ngmainbackgroud"))
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoManager.shared.addTask(info: "desc1",title: "haha" )
        TodoManager.shared.addTask(info: "desc2",title: "haha" )
        TodoManager.shared.addTask(info: "desc3",title: "haha1" )
        TodoManager.shared.addTask(info: "desc4",title: "haha1" )
        TodoManager.shared.addTask(info: "desc5",title: "haha1" )
        TodoManager.shared.addTask(info: "desc6",title: "haha1" )
        return ContentView().previewDevice("iPhone 13")
    }
}
