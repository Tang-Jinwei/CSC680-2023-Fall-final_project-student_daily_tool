//  Created by Tang Jinwei on 10/18/23.
//

import SwiftUI
import Foundation

struct crossOut: ViewModifier {
    func body(content: Content) -> some View {
        content
            .strikethrough(true, color: ThemeController.theme.themeColor)
    }
}

extension Text {
    func animatableStrikethrough(_ isActive: Bool = true,
                                 pattern: Text.LineStyle.Pattern = .solid,
                                 textColor:Color? = nil,
                                 color: Color? = nil) -> some View {
        self
            .foregroundColor(textColor)
            .overlay(alignment:.leading) {
                self
                    .foregroundColor(.clear)
                    .strikethrough(isActive,color: color)
                    .scaleEffect(x:isActive ? 1 : 0,anchor: .leading)
            }
    }
}

struct TodoItemView: View {
    
    @Binding
    var todoLine: TodoItem
    
    var body: some View {
        ZStack {
            HStack {
                Text("\(todoLine.taskString)")
                    .font(.system(size: 18))
                    .animatableStrikethrough(todoLine.isDone,
                                             textColor: Color.primary,
                                             color:ThemeController.theme.themeColor)
                    .animation(.easeInOut(duration: 1), value: todoLine.isDone)
                    .lineLimit(1)
                    .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                    .contentShape(Rectangle())
                Spacer()
                Divider()
                HStack{
                    Text("\(todoLine.dueDate.formatted(Date.FormatStyle().month())) \(todoLine.dueDate.formatted(Date.FormatStyle().day()))")
                    
                        .font(.system(size: 15))
                        .animatableStrikethrough(todoLine.isDone,
                                                 textColor: Color.primary,
                                                 color:ThemeController.theme.themeColor)
                        .animation(.easeInOut(duration: 0.5), value: todoLine.isDone)
                        .lineLimit(1)
                        .frame(width: 50,alignment: .leading)
                        
                    
                }
            }
            
        }
        
       
//        .strikethrough(todoLine.isDone ? true : false, color: .blue)
        .contentShape(Rectangle())
        
    }
}

#Preview {
    TodoItemView(todoLine: .constant(Course.sampleData[0].todoList[0]))
}
