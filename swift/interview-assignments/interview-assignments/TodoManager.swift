//
//  TodoManager.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI
import Combine

class TodoManager: ObservableObject {
 

}

class Todo: Identifiable ,ObservableObject {
    var id:  UUID = UUID()
    var title: String = ""
    var groupName: String = ""
    var hasDelete : Bool=false
    var disable : Bool=true
    private  init() {
    }
    public  init(title: String,groupName: String = "") {
        self.title=title
        self.groupName=groupName
    }
}
//var todoList=[Todo(title: "title1",groupName:"haha"), Todo(title: "title2",groupName:"haha"), Todo(title: "title13",groupName:"haha"), Todo(title: "title4",groupName:"haha1")]
