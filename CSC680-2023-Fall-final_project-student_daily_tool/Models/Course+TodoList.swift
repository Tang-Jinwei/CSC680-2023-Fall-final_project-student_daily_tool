import Foundation


struct Course: Identifiable {
    let id: UUID
    let courseName: String
    let todoList: [todoLine]
    
    init(id: UUID = UUID(), courseName: String, todoList: [todoLine]) {
        self.id = id
        self.courseName = courseName
        self.todoList = todoList
    }
}

struct todoLine: Identifiable {
    let id: UUID
    let taskString: String
    let isDone: Bool
    
    init(id: UUID = UUID(), taskString: String, isDone: Bool = false) {
        self.id = id
        self.taskString = taskString
        self.isDone = isDone
    }
}

extension Course {
    static let sampleData = [
        Course(courseName: "CSC680", todoList: [
            todoLine(taskString: "Finish assignment 1,abbsddsjodsjdojsdojsodjsjods"),
            todoLine(taskString: "Reading 1")
        ]),
        Course(courseName: "CSC645", todoList: [
            todoLine(taskString: "Online reading"),
            todoLine(taskString: "Midterm exam")
        ]),
        Course(courseName: "CSC656", todoList: [
            todoLine(taskString: "Permultter"),
            todoLine(taskString: "Reading page 107 to 200")
        ])
    ]
}

