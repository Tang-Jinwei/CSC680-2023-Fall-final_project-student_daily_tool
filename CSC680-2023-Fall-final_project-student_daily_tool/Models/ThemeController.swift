//
//  ThemeController.swift
//  CSC680-2023-Fall-final_project-student_daily_tool
//
//  Created by Tang Jinwei on 12/4/23.
//

import Foundation
import SwiftUI

class ThemeController: ObservableObject {
    
    static let theme = ThemeController()
    @Published var themeColor: Color = .cyan
}
