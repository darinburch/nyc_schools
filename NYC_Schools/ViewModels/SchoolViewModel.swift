
import Foundation
import CoreData

struct SchoolViewModel {
    
    let school: School
    
    var id: NSManagedObjectID {
        return school.objectID
    }
    
    var dbn: String {
        return school.dbn ?? NA
    }
    
    var school_name: String {
        return school.school_name ?? NA
    }
    
    var overview_paragraph: String {
        return school.overview_paragraph ?? NA
    }
    
    var location: String {
        return school.location ?? NA
    }
    
    var phone_number: String {
        return school.phone_number ?? NA
    }
    
    var school_email: String {
        return school.school_email ?? NA
    }
    
    var website: String {
        return school.website ?? NA
    }
    
    var total_students: String {
        return school.total_students ?? NA
    }
}

