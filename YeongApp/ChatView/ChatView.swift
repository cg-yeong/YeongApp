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
    @IBOutlet weak var mainBtn: UIButton!
    
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
    
}
