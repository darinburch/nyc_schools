
import Foundation


enum SchoolOrder {
    
    case name, studentCount
    
    func key() -> String {
        switch self {
        case .name:
            return "school_name"
        case .studentCount:
            return "total_students"
        }
    }
}
