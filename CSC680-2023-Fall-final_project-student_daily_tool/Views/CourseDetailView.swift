//
//  CourseDetailView.swift
//  CSC680-2023-Fall-final_project-student_daily_tool
//
//  Created by Tang Jinwei on 12/4/23.
//

import SwiftUI

struct CourseDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var courses: [Course]
    @Binding var currentCourse: Course
    
    func removeCourse(_ course: Course) {
        let courseIndex = courses.firstIndex{ $0.id == course.id }
        guard let courseIndex = courseIndex else {
            return
        }
        courses.remove(at: courseIndex)
    }
    
    var body: some View {
        VStack {
            Text(currentCourse.courseName)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text(currentCourse.semester.rawValue)
            Text(currentCourse.year.description)
            Spacer()
            List{
                Section (header: Text("TO DO")) {
                    ForEach($currentCourse.todoList) { $todoItem in
                        TodoItemView(todoLine: $todoItem)
                    }
                }
                Section(header: Text("HISTORY")) {
                    if(currentCourse.history.isEmpty){
                        Text("No history yet")
                    }
                    ForEach($currentCourse.history) { $todoItem in
//                        Text(todoItem.taskString)
                        TodoItemView(todoLine: $todoItem)
                    }
                }
                Button {
                    removeCourse(currentCourse)
                    dismiss()
                } label: {
                    HStack{
                        Spacer()
                        Text("Delete Course")
                        Spacer()
                    }
                }
                .foregroundStyle(Color.red)
            }
            Spacer()
                        
        }
    }
}

#Preview {
    CourseDetailView(courses: .constant(Course.sampleData),currentCourse: .constant(Course.sampleData[0]))
}
