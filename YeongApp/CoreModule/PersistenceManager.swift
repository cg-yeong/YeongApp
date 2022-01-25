//
//	PersistenceManager.swift
//	YeongApp
//

import Foundation
import CoreData

class PersistenceManager {
    
//    class var sharedInstance : PersistenceManager {
//        struct Static {
//            static let instance : PersistenceManager = PersistenceManager()
//        }
//        return Static.instance
//    }
    
    //MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Model") //The name of the .xcdatamodeld file
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                // fatalError로 인해 앱이 충돌 로그 생성하고 종료된다 개발중 유용하지만 실제 앱에선 그닥
                /**
                 * 오류의 일반적인 원인
                 * 상위 디렉터리가 없거나 만들수 없거나 쓰기를 허용하지 않음
                 * 디바이스가 잠겨있을 때 권한 또는 데이터 보호로 인해 영구 저장소에 액세스 불가능
                 * 장치에 공간이 부족
                 * 저장소를 현재 모델 버전으로 마이그레이션 할 수 없음. 오류 메시지 확인
                 */
                
                print(error)
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving Support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func delete(object: NSManagedObject) {
        self.context.delete(object)
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(delete)
        } catch {
            
        }
    }
    
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int? {
        do {
            let count = try self.context.count(for: request)
            return count
        } catch {
            return nil
        }
    }
    
    func insertPerson(person: Person) {
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(person.name, forKey: "name")
            managedObject.setValue(person.phoneNumber, forKey: "phoneNumber")
            managedObject.setValue(person.shortNumber, forKey: "shortNumber")
            managedObject.setValue(person.habbit, forKey: "habbit")
            
            do {
                try self.context.save()
            } catch {
            }
        } else {
        }
    }
}
