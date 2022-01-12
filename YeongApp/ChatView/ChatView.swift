//
//  ChatView.swift
//  YeongApp
//
//  Created by inforex on 2022/01/10.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ChatView: XibView {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var floatingView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var floatingBtn: UIButton!
    @IBOutlet weak var fResume: UIButton!
    
    let bag = DisposeBag()
    override func layoutSubviews() {
        super.layoutSubviews()
        if isInitialized {
            initialize()
            
            isInitialized = false
        }
    }
    
    func initialize() {
        floatingBtn.rx.tap
            .bind {[weak self] in
                self?.toggleFloating(true)
            }.disposed(by: bag)
        
        fResume.rx.tap
            .bind {[weak self] in
                self?.toggleFloating(false)
            }.disposed(by: bag)
    }
    
    
    
    @IBAction func closeChatView(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    func toggleFloating(_ mode: Bool) {
        if mode {
            loadingSubview(mode, floatingView)
        } else {
            loadingSubview(mode, mainView)
        }
    }
    
    func loadingSubview(_ floatingMode: Bool, _ subview: UIView) {
        if floatingMode {
            floatingView.translatesAutoresizingMaskIntoConstraints = false
            frame = CGRect(x: 0, y: UIScreen.main.bounds.height - self.safeAreaInsets.bottom - 100, width: UIScreen.main.bounds.width, height: 50)
            
            mainView.isHidden = true
            addSubview(floatingView)
            let constraints = [
                floatingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                floatingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                floatingView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.safeAreaInsets.bottom)
            ]
            NSLayoutConstraint.activate(constraints)
        } else {
            floatingView.removeFromSuperview()
            frame = UIScreen.main.bounds
            
            mainView.isHidden = false
            App.presenter.navigationViewController?.popToRootViewController(animated: true)
        }
    }
    
}
