//  Created by Tang Jinwei on 10/18/23.
//

import SwiftUI

class tabController:ObservableObject {
    @Published var selectedTab = 0
}

@main
struct CSC680_2023_Fall_final_project_student_daily_toolApp: App {
    
    @StateObject var tab = tabController()
    
    @StateObject var data = CourseTodoData()
    
    @State var sample: [Course] = Course.sampleData
    
    var body: some Scene {
        WindowGroup {
            MainView(selectedTabIndex: $tab.selectedTab, courses: $data.courses){
                Task{
                    do {
                        try await data.save(courses: data.courses)
                    } catch {
                    }
                }
            }
            .task {
                do {
                    try await data.load()
                } catch {
                }
            }
            .environmentObject(tab)
            .tint(ThemeController.theme.themeColor)
        }
    }
}
