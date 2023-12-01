//  Created by Tang Jinwei on 10/18/23.
//

import SwiftUI

struct TODOListView: View {
    
    @Binding var courses: [Course]
    
    var body: some View {
        
//        Text("Todo List")
//            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        
        NavigationStack {
            List {
                ForEach($courses) { $course in
                    Section (header: Text(course.courseName)){
                        ForEach(course.todoList) { todoLine in
                            TodoView(todoLine: todoLine)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
        }
        }
        Text("TBD")
            
        
    }
}


#Preview {
    TODOListView(courses: .constant(Course.sampleData) )
}
