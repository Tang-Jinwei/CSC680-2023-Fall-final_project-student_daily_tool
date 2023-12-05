//  Created by Tang Jinwei on 12/3/23.
//

import Foundation
import SwiftUI

enum Semester: String,CaseIterable,Codable {
    case spring = "Spring", summer = "Summer", fall = "Fall", winter = "Winter", none = "None"
    
    static var allCases: [Semester] {
        [.spring,.summer,.fall,.winter,.none]
    }
    
}
