//
//  ViewController.swift
//  YeongApp
//
//  Created by inforex on 2022/01/10.
//

import UIKit


class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var mainPlate: UIView!
    @IBOutlet weak var con: UIView!
    
    private let width = 200.0
    private let height = 55.0
    
    private lazy var protoChatBalloon: ScrollChatBaloon = {
        let bubble = ScrollChatBaloon()
        bubble.viewColor = .orange
        bubble.tipHeight = 5
        bubble.tipWidth = 10
        
        return bubble
    }()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
        App.presenter.mainVC = self
        
        self.view.addSubview(self.protoChatBalloon)
        self.protoChatBalloon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(self.width)
        }
        
    }

    
    
    
    
    
    
    
    
}

