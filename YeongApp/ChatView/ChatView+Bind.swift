//
//	ChatView+Bind.swift
//	YeongApp
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa
import UIKit

extension ChatView {
    
    func bind() {
        let down_tap = UITapGestureRecognizer()
        self.addGestureRecognizer(down_tap)
        
        down_tap.rx.event
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.chatTextView.endEditing(true)
            }.disposed(by: bag)
        
        floatingBtn.rx.tap
            .bind {[weak self] in
                self?.toggleFloating(true)
            }.disposed(by: bag)
        
        mainBtn.rx.tap
            .bind { [weak self] in
                self?.toggleFloating(false)
            }.disposed(by: bag)
        
        closeBtn.rx.tap
            .bind { [weak self] in
                self?.removeFromSuperview()
            }.disposed(by: bag)
        
        chatSendBtn.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                guard let text = self.chatTextView.text else { return }
            }.disposed(by: bag)
        
        
        
    }
}
