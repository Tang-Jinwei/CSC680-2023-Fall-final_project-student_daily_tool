//  Created by Tang Jinwei on 10/18/23.
//

import SwiftUI

@main
struct CSC680_2023_Fall_final_project_student_daily_toolApp: App {
    
    @State var courses: [Course] = Course.sampleData
    
    var body: some Scene {
        WindowGroup {
            TODOListView(courses: $courses)
        }
    }
}
