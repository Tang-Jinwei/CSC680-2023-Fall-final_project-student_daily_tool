//
//  MainView.swift
//  CSC680-2023-Fall-final_project-student_daily_tool
//
//  Created by Tang Jinwei on 12/4/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Binding var selectedTabIndex: Int
    @Binding var courses: [Course]
    let saveAction: ()->Void
    
    
    @EnvironmentObject var tab: tabController
    
    var body: some View {
        VStack {
            TabView(selection: $tab.selectedTab) {
                Group{
                    DueSoonView(courses: $courses)
                        .tag(0)
                        .tabItem {
                            Label("Home",systemImage: "house.fill")
                        }
                    
                    CourseTodoListView(courses: $courses)
                        .tag(1) // 3
                        .tabItem {
                            Label("To Do", systemImage: "list.bullet")
                        }
                    
                    CourseEditView(courses: $courses)
                        .tag(2)
                        .tabItem {
                            Label("Course", systemImage: "book.closed.fill")
                        }
                }
                .toolbarBackground(Color.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                
                
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
        
    }
}

#Preview {
    MainView(selectedTabIndex: .constant(0), courses: .constant(Course.sampleData), saveAction: {})
}
