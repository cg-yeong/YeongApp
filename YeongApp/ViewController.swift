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
    }

    @IBAction func openChat(_ sender: Any) {
        
        let chatView = ChatView()
        chatView.frame = self.con.bounds
        chatView.backgroundColor = .green
        self.con.addSubview(chatView)
    }
    
    func visibleViewController() {
        
    }
}

