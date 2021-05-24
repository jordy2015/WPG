//
//  DatabaseHandler.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import CoreData
import UIKit

class DatabaseHandler {
    fileprivate let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else {
            return nil
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else {
            return nil
        }
        
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("->CoreData: \(error.localizedDescription)")
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print("->CoreData: \(error.localizedDescription)")
            return []
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) {
        viewContext.delete(object)
        save()
    }
}

extension DatabaseHandler {
    func searchPhoto(with id: String) -> Photo? {
        let request = Photo.fetchRequest()

        let predicate = NSPredicate(format: "id = %@", id)
        request.predicate = predicate

        do {
            let photo = try self.viewContext.fetch(request)
            return photo.first as? Photo
        } catch {
            print("->CoreData: \(error.localizedDescription)")
            return nil
        }
    }
}
