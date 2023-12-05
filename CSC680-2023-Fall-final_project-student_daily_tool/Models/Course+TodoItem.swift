import Foundation
import SwiftUI
import LoremSwiftum

struct Course: Identifiable,Codable {
    let id: UUID
    let courseName: String
    let semester: Semester
    let year: Int = Int(Date().formatted(Date.FormatStyle().year())) ?? 0
    var todoList: [TodoItem]
    
    var history: [TodoItem] = []
    
    init(id: UUID = UUID(), courseName: String, semester: Semester, todoList: [TodoItem]) {
        self.id = id
        self.courseName = courseName
        self.semester = semester
        self.todoList = todoList
    }
}

struct TodoItem: Identifiable,Codable {
    let id: UUID
    var taskString: String
    var isDone: Bool
    var dueDate: Date
    
    init(id: UUID = UUID(), taskString: String, isDone: Bool = false, dueDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!) {
        self.id = id
        self.taskString = taskString
        self.isDone = isDone
        self.dueDate = dueDate
    }
}

extension Course {
    static let sampleData = [
        Course(courseName: "CSC680", semester: .fall, todoList: [
            TodoItem(taskString: "Finish assignment 1,Finish assignment 1,Finish assignment 1,",dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!),
            TodoItem(taskString: "Reading 1",dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!),
            TodoItem(taskString: Lorem.sentence,dueDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!)
        ]),
        Course(courseName: "CSC645", semester: .fall, todoList: [
            TodoItem(taskString: "Online reading"),
            TodoItem(taskString: "Midterm exam")
        ]),
        Course(courseName: "CSC656", semester: .fall, todoList: [
            TodoItem(taskString: "Permultter experiment"),
            TodoItem(taskString: "Reading page 107 to 200")
        ])
    ]
    
    static func getCourseNameList(_ courses: [Course]) -> [String]{
        courses.map{ $0.courseName }
    }
}

extension TodoItem {
    static let emptyTodoItem = TodoItem(taskString: "")
}
