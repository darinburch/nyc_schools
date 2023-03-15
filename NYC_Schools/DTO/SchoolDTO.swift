
import Foundation
import CoreData

  
struct SchoolDTO: Decodable {
    let dbn: String
    let school_name: String?
    let overview_paragraph: String?
    let location: String?
    let phone_number: String?
    let school_email: String?
    let website: String?
    let total_students: String?
}
