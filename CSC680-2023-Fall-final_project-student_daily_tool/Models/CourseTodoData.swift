
//  Created by Tang Jinwei on 12/1/23.
//

import SwiftUI
import Foundation

// Below implementations are mainly from Apple's Scrumdinger tutorial
@MainActor
class CourseTodoData: ObservableObject {
    
    @Published var courses: [Course] = Course.sampleData
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("Course.data")
    }
    
    func load() async throws {
        let task = Task<[Course], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let courses = try JSONDecoder().decode([Course].self, from: data)
            return courses
        }
        let courses = try await task.value
        self.courses = courses
    }
    
    func save(courses: [Course]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(courses)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
