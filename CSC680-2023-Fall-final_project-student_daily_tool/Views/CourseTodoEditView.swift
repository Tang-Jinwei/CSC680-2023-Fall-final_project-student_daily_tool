//
//  CourseTodoEdditingView.swift
//  CSC680-2023-Fall-final_project-student_daily_tool
//
//  Created by Tang Jinwei on 12/1/23.
//

import SwiftUI

@MainActor
struct CourseTodoEditView: View {
    
    @Binding var courses: [Course]
    @Binding var isEditing: Bool
    @Binding var isEditingCurrentItem: Bool
    @Binding var todoItem: TodoItem
    @Binding var currentCourse: Course
    
    @State var selectedDate = Date()
    
    @State var currentCourseName:String = ""
    
    
    func quitEdditing() {
        isEditing = false
        todoItem = TodoItem(taskString: "")
        isEditingCurrentItem = false
        currentCourse =  Course(courseName: "", semester: .none, todoList: [])
    }
    
    func coursePicker() -> some View{
        var courseNameList = Course.getCourseNameList(courses)
        return Picker("Course", selection: $currentCourseName,content: {
            ForEach(0..<courseNameList.count) { index in
                Text(courseNameList[index]).tag(courseNameList[index])
            }
        })
    }
    
    func loadInfo() {
        if(currentCourse.courseName == ""){
            currentCourseName = courses[0].courseName
            selectedDate = Date()
        }else {
            currentCourseName = currentCourse.courseName
            selectedDate = todoItem.dueDate
        }
    }
    
    func onDone() {
        var removedItem: TodoItem
        if(isEditingCurrentItem){
            let itemIndex = currentCourse.todoList.firstIndex{ $0.id == todoItem.id }
            guard let itemIndex = itemIndex else {
                isEditingCurrentItem = false
                return
            }
            // store task string and date
            currentCourse.todoList[itemIndex].taskString = todoItem.taskString
            currentCourse.todoList[itemIndex].dueDate = selectedDate
            
            // move todo item if course selection is changed
            if(currentCourseName != currentCourse.courseName) {
                removedItem = currentCourse.todoList.remove(at: itemIndex)
                let courseIndex = courses.firstIndex{ $0.courseName == currentCourseName}
                guard let courseIndex = courseIndex else {
                    isEditingCurrentItem = false
                    return
                }
                courses[courseIndex].todoList.append(removedItem)
            }
            
            let courseIndex = courses.firstIndex{ $0.id == currentCourse.id}
            guard let courseIndex = courseIndex else {
                isEditingCurrentItem = false
                return
            }
            courses[courseIndex] = currentCourse
            isEditingCurrentItem = false
        }
        else{
            print("Add new item")
            let courseIndex = courses.firstIndex{ $0.courseName == currentCourseName}
            guard let courseIndex = courseIndex else {
                isEditingCurrentItem = false
                return
            }
            courses[courseIndex].todoList.append(todoItem)
        }
    }
    
    
    
    func dueDatePicker() -> some View {
        DatePicker(selection: $selectedDate,in: Date()...,displayedComponents: [.hourAndMinute,.date],label: {Text("Due Date")})
            .datePickerStyle(.graphical)
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    coursePicker()
                    dueDatePicker()

                    TextEditor(text: $todoItem.taskString)
                            .frame(height: 200)
//                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(ThemeController.theme.themeColor, lineWidth: 0.5))
                }
            }
            .scrollContentBackground(.hidden)
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        quitEdditing()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done"){
                        onDone()
                        quitEdditing()
                    }
                }
            }
            .onAppear {
                loadInfo()
            }
            .onDisappear {
                quitEdditing()
            }
            .navigationTitle("Todo Item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    CourseTodoEditView(courses: .constant(Course.sampleData), isEditing: .constant(true), isEditingCurrentItem: .constant(true), todoItem: .constant(TodoItem.emptyTodoItem), currentCourse: .constant(Course.sampleData[0]))
}
