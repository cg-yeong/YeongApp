//
//  ViewController.swift
//  YeongApp
//
//  Created by inforex on 2022/01/10.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var con: UIView!
    @IBOutlet weak var chatBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
        App.presenter.mainVC = self
    }

    @IBAction func openChat(_ sender: Any) {
        if let _ = App.presenter.contextView as? ChatView {
            return
        }
        let chatView = ChatView()
        chatView.frame = self.view.bounds
        App.presenter.contextView = chatView
        self.view.addSubview(chatView)
    }
    
    func visibleViewController() {
        
    }
}

