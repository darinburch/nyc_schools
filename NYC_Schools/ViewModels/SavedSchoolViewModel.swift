
import Foundation
import CoreData

class SavedSchoolsViewModel: ObservableObject {
    
    @Published var savedSchools: [SchoolViewModel] = []
    
    func loadSchools() {
        let schools = CoreDataManager.shared.loadSchools()
        DispatchQueue.main.async {
            self.savedSchools = schools.map(SchoolViewModel.init)
        }
    }
    
    func deleteSchool(_ school: SchoolViewModel) {
        if let school = CoreDataManager.shared.loadSchool(school.id){
            DispatchQueue.main.async {
                CoreDataManager.shared.deleteSchool(school)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.loadSchools()
                }
            }
        }
    }
    
    func deleteSchoolByDbn(_ dbn: String) {
        
    }
    
    init() {
        loadSchools()
    }
    
    
}
