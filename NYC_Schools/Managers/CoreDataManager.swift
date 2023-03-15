
import Foundation
import CoreData


class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save school")
        }
    }
    
    /// load single school only for deleting it
    func loadSchool(_ id: NSManagedObjectID) -> School? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? School
        } catch {
            print (error)
            return nil
        }
    }
    
    func loadSchools() -> [School] {
        let schoolFetchRequest: NSFetchRequest<School> = School.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(schoolFetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteSchool(_ school: School) {
        persistentContainer.viewContext.delete(school)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
    
    private init() {
        self.persistentContainer = NSPersistentContainer(name: "CoreDataModels")
        persistentContainer.loadPersistentStores { (desc, err) in
            if let error = err {
                fatalError("Could not load from Core Data: \(error.localizedDescription)")
            }
        }
    }
    
}
