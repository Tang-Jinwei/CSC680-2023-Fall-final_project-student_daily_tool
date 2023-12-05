//  Created by Tang Jinwei on 10/18/23.
//

import SwiftUI

class CourseTODOEdditViewController: ObservableObject {
    
    
}

private struct CenterHorizontallyModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            Spacer()
            content
            Spacer()
        }
    }
}

struct CourseTodoListView: View {

    @Binding var courses: [Course]
    @State var isEditing = false
    @State var isEditingCurrentItem = false
    @State var isDone = false
    @State var currentCourse = Course(courseName: "",semester: .none, todoList: [])
    @State var edditingTodoItem = TodoItem(taskString: "")
    
    var frequency: TimeInterval { 3.0 }
    
    @EnvironmentObject var tab: tabController
    
//    var courseController = CourseTODOListViewController()
    
    var body: some View {
        NavigationStack {
            if (courses.isEmpty) {
                VStack {
                    Text("No courses yet")
                }
                Button {
                    tab.selectedTab = 2
                } label: {
                    NavigationLink {
                        CourseEditView(courses: $courses)
                    } label: {
                        Text("Add Course")
                    }

                }
            }
            else {
                displayCourse(courses)
            }
        }
    }
}

@MainActor
extension CourseTodoListView {
    
    func findIndex(_ course: Course , _ todoItem: TodoItem) -> Int {
        let itemIndex = course.todoList.firstIndex{ $0.id == todoItem.id }
        guard let itemIndex = itemIndex else {
            return -1
        }
        return itemIndex
    }
    
    func remove(_ course: Course, _ todoLine: TodoItem) {
        
    }
    
    func displayCourse(_ courses:[Course]) -> some View {
        List {
            ForEach($courses) { $course in
                Section (header: HStack{ Image(systemName: "book.closed.fill"); Text(course.courseName) }.foregroundStyle(Color.white)){
                    ForEach($course.todoList) { $todoLine in
                        HStack{
                            Button(action: {
                                todoLine.isDone.toggle()
                            }){
                                Image(systemName: todoLine.isDone ? "checkmark": "square")
                                                    .contentTransition(.symbolEffect(.replace))
                                                    .foregroundStyle(ThemeController.theme.themeColor)
                                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                            }
                            .frame(width: 20)
                            .padding(.trailing)
                            
                            TodoItemView(todoLine: $todoLine)
                                .onTapGesture { location in
                                    isEditing = true
                                    isEditingCurrentItem = true
                                    edditingTodoItem = todoLine
                                    currentCourse = course
                                }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                            Button {
                                let index = findIndex(course, todoLine)
                                if(todoLine.isDone){
                                    withAnimation {
                                        let removedItem = course.todoList.remove(at: index)
                                        course.history.append(removedItem)
                                    }
                                }
                            } label: {
                                Text("Move to history")
                            }
                        })
                        .listRowSeparatorTint(ThemeController.theme.themeColor)
                        
                    }
                    .onMove { indexSet, index in
                        course.todoList.move(fromOffsets: indexSet, toOffset: index)
                    }

                    .onDelete { indices in
                        withAnimation {
                            course.todoList.remove(atOffsets: indices)
                        }
                    }
                    Button(action: {
                        isEditing = true
                        currentCourse = course
                    }) {
                        Image(systemName: "plus").modifier(CenterHorizontallyModifier())
                    }
                }
            }
        }
        .background(ThemeController.theme.themeColor.opacity(0.6))
//        .listRowSpacing(5)
        .navigationTitle("To Do")
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .listStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: CourseEditView(courses: $courses)) {
                    Image(systemName: "folder.badge.gearshape")
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            CourseTodoEditView(courses: $courses, isEditing: $isEditing,isEditingCurrentItem: $isEditingCurrentItem, todoItem: $edditingTodoItem,currentCourse: $currentCourse)
        }
    }
}

