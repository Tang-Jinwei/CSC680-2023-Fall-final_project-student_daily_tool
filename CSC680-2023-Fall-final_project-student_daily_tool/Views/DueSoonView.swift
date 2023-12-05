//
//  TodayMustDoView.swift
//  CSC680-2023-Fall-final_project-student_daily_tool
//
//  Created by Tang Jinwei on 12/4/23.
//

import SwiftUI

struct DueSoonView: View {
    
    @State var selectedPicker: Int = 1
    
    @Binding var courses: [Course]
    
    @EnvironmentObject var tab: tabController
    
    func getDiff(_ start: Date, _ end: Date) -> DateComponents {
        Calendar.current.dateComponents([.minute], from: start, to: end)
    }
    
    func checkIfLessThanDay(dueDate: Date,_ days: Int) -> Bool{
        let current = Date()
        let diffs = getDiff(current, dueDate)
        let minues = days * 24 * 60 // 1 day = 24 hrs/day * 60 mins/hr
        let minuesDiff = diffs.minute
        guard let minuesDiff = minuesDiff else {
            return false
        }
        return (minuesDiff <= minues) ? true : false
 
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker(selection: $selectedPicker.animation(), label: Text("Option")) {
                    Text("In a day").tag(1)
                    Text("In three days").tag(3)
                    Text("In a week").tag(7)
                }
                .pickerStyle(SegmentedPickerStyle())

                List {
                    ForEach(courses) { course in
                        Section (header: HStack{ Image(systemName: "book.closed.fill");Text(course.courseName)
                        }.foregroundStyle(ThemeController.theme.themeColor)){
                            ForEach(course.todoList) { todoItem in
                                if( checkIfLessThanDay(dueDate: todoItem.dueDate,selectedPicker)){
                                    Text("\(todoItem.taskString)")
                                        .transition(.slide)
                                        .lineLimit(1)
                                        
                                }
                            }
                        }
                        .onTapGesture {
                            tab.selectedTab = 1
                        }
                        
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Heads up!")
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    DueSoonView(courses: .constant(Course.sampleData))
}
