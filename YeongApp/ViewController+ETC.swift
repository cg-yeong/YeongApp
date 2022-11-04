//
//	ViewController+ETC.swift
//	YeongApp
//

import Foundation
import CoreData

struct Person {
    var name: String
    var phoneNumber: String
    var shortNumber: Int
    var habbit: [String]
}
extension ViewController {
    
    
    @IBAction func openChat(_ sender: Any) {
        App.presenter.addSubview(.visibleView, type: ChatView.self) { view in
            view.tag = 1010
            App.presenter.contextView = view
        }
    }
    
    
    @IBAction func likePopup(_ sender: Any) {
        App.presenter.addSubview(.visibleView, type: LikePopup.self) { view in
            view.tag = 1010
            App.presenter.contextView = view
        }
    }
    
    
    
}
