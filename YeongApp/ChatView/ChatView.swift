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
import SwiftyJSON

class ChatView: XibView {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var floatingView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var floatingBtn: UIButton!
    @IBOutlet weak var fResume: UIButton!
    
    @IBOutlet weak var chatCollectionView: UICollectionView!
    
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var chatSendBtn: UIButton!
    
    @IBOutlet weak var chatView_constraint_bottom: NSLayoutConstraint!
    
    
    var chatDatas: [JSON] = []
    
    let bag = DisposeBag()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isInitialized {
            initialize()
            
            isInitialized = false
        }
    }
    
    func initialize() {
        addObserver()
        setChatCollectionView()
        bind()
    }
    
    
    
    
    @IBAction func closeChatView(_ sender: Any) {
        self.removeFromSuperview()
        App.presenter.contextView = nil
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
            //frame = CGRect(x: 0, y: UIScreen.main.bounds.height - self.safeAreaInsets.bottom - 100, width: UIScreen.main.bounds.width, height: 50)
            floatingView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            //mainView.isHidden = true
            addSubview(floatingView)
            floatingView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            floatingView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            floatingView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.safeAreaInsets.bottom).isActive = true
            
            UIView.transition(with: self, duration: 2, options: .transitionCurlUp) {
                self.mainView.isHidden = true
            } completion: { _ in
                self.floatingView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - self.safeAreaInsets.bottom - 100, width: UIScreen.main.bounds.width, height: 50)
            }

        } else {
            //floatingView.removeFromSuperview()
            //frame = UIScreen.main.bounds
            //mainView.isHidden = false
            UIView.transition(with: self, duration: 2, options: .transitionCurlDown) {
                self.floatingView.removeFromSuperview()
                self.frame = UIScreen.main.bounds
            } completion: { _ in
                self.mainView.isHidden = false
            }

            App.presenter.navigationViewController?.popToRootViewController(animated: true)
        }
    }
    
}
