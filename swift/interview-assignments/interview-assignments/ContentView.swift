//
//  ContentView.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI


import SwiftUI

struct ContentView: View {
    @EnvironmentObject var todoManager: TodoManager
    
    func deleteRow(at offsets:IndexSet) {
      
        
    }
    func moveItem(from source: IndexSet, to destination: Int) {
        
    }
    
    func todoIndexPath(todo:Todo) -> IndexPath {
        var section :Int = 0
        var row :Int = 0
        for oneTodoGroup in todoManager.todoGroups {
           
            for oneTodo in oneTodoGroup.todos {
                if oneTodo.id == todo.id {
                    return IndexPath(row: row, section: section)
                }
                row = row + 1
            }
            section = section + 1
        }
        return IndexPath(row: -1, section: -1)
    }
    
    init(){
        UITableView.appearance().separatorColor = UIColor.clear

    }
    var body: some View {
        return  NavigationView{
            VStack {
                List {
                    ForEach(todoManager.todoGroups) { oneTodoGroup in
                        Section(header: Text(oneTodoGroup.groupName).font(.title).foregroundColor(Color("ngtextback")))
                        {
                            ForEach(oneTodoGroup.todos) { oneTodo in
                                ToDoTVCell(todo:oneTodo).onLongPressGesture {
                                    let indexPath = self.todoIndexPath(todo: oneTodo)
                                    todoManager.todoGroups[indexPath.section].todos[indexPath.row].hasDelete=true
                                }
                            }.onDelete(perform: { offsets in

                            }).onLongPressGesture(perform: {
                                
                            })
                            .listRowBackground(Color.clear)
                          
                        }
                       
                    }

                }.listStyle(GroupedListStyle()).background(Color.blue)
                Spacer()
                
                BottomInputView().layoutPriority(1)

            }.navigationTitle(Text("List").font(.largeTitle).foregroundColor(Color("ngtextgraybackgroud")))
                .background(Color("ngmainbackgroud"))
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let todoManager = TodoManager()
        todoManager.addTask(title: "desc1",groupName: "haha" )
        todoManager.addTask(title: "desc2",groupName: "haha" )
        todoManager.addTask(title: "desc3",groupName: "haha1" )
        todoManager.addTask(title: "desc4",groupName: "haha1" )
        todoManager.addTask(title: "desc5",groupName: "haha1" )
        todoManager.addTask(title: "desc6",groupName: "haha1" )
        return ContentView().previewDevice("iPhone 13").environmentObject(todoManager)
    }
}
