//
//  interview_assignmentsApp.swift
//  interview-assignments
//
//  Created by never88gone on 2022/1/6.
//

import SwiftUI

@main
struct interview_assignmentsApp: App {
    var body: some Scene {
        let todoManager = TodoManager()
        todoManager.addTask(title: "desc1",groupName: "haha" )
        todoManager.addTask(title: "desc2",groupName: "haha" )
        todoManager.addTask(title: "desc3",groupName: "haha1" )
        todoManager.addTask(title: "desc4",groupName: "haha1" )
        todoManager.addTask(title: "desc5",groupName: "haha1" )
        todoManager.addTask(title: "desc6",groupName: "haha1" )
       return  WindowGroup {

            ContentView().environmentObject(todoManager)
        }
    }
}
