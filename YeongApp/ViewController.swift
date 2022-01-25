//
//  ViewController.swift
//  YeongApp
//
//  Created by inforex on 2022/01/10.
//

import UIKit
import CoreData

struct Person {
    var name: String
    var phoneNumber: String
    var shortNumber: Int
    var habbit: [String]
}

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var con: UIView!
    @IBOutlet weak var chatBtn: UIButton!
    
    let yeong = Person(name: "Yeong", phoneNumber: "010-3333-4444", shortNumber: 1, habbit: ["game", "vi"])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
        App.presenter.mainVC = self
        
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: App.data.persistence.context)
        if let entity = entity {
            let person = NSManagedObject(entity: entity, insertInto: App.data.persistence.context)
            person.setValue(yeong.name, forKey: "name")
            person.setValue(yeong.phoneNumber, forKey: "phoneNumber")
            person.setValue(yeong.shortNumber, forKey: "shortNumber")
            
            do {
                try App.data.persistence.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        let walker = Person(name: "Walker", phoneNumber: "010-1234-5678", shortNumber: 2, habbit: ["games", "asdf"])
        App.data.persistence.insertPerson(person: walker)
    }

    @IBAction func openChat(_ sender: Any) {
//        if let _ = App.presenter.contextView as? ChatView {
//            return
//        }
//        let chatView = ChatView()
//        chatView.frame = self.view.bounds
//        App.presenter.contextView = chatView
//        self.view.addSubview(chatView)
//        do {
//            //try PersistenceManager.sharedInstance.context.fetch(Contact.fetchRequest())
//            let contact = try App.data.persistence.context.fetch(Contact.fetchRequest())
//            contact.forEach {
//                print($0.name, $0.phoneNumber, $0.shortNumber)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
        
        // delete
        let dequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        let detchResult = App.data.persistence.fetch(request: dequest)
        App.data.persistence.delete(object: detchResult.first ?? NSManagedObject())
        
        // fetch
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        let fetchResult = App.data.persistence.fetch(request: request)
        print(App.data.persistence.count(request: request))
        fetchResult.forEach {
            print($0.name!, $0.phoneNumber!, $0.shortNumber)
        }
        
        // deleteAll
        let dAquest: NSFetchRequest<Contact> = Contact.fetchRequest()
        let dAetchResutl = App.data.persistence.deleteAll(request: dAquest)
        let arr = App.data.persistence.fetch(request: dAquest)
        if arr.isEmpty {
            print("clean")
        }
        
        
        
        
    }
    
    func visibleViewController() {
        
    }
}

