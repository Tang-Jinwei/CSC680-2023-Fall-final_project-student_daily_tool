//
//  TodoView.swift
//  CSC680-2023-Fall-final_project-student_daily_tool
//
//  Created by Tang Jinwei on 10/18/23.
//

import SwiftUI

struct TodoView: View {
    
    let todoLine: todoLine
    
    var body: some View {
        HStack {
            Button(action: {}){
                Image(systemName: "circle")
            }
            Text("\(todoLine.taskString)")
                .lineLimit(1)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
            Spacer()
        }
        
    }
}

#Preview {
    TodoView(todoLine: Course.sampleData[0].todoList[0])
        
}
