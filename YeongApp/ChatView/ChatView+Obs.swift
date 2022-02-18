//
//	ChatView+Obs.swift
//	YeongApp
//

import Foundation
import UIKit

extension ChatView {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
        let userInfo = noti.userInfo!
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        if let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottom = keyboardSize.height - self.safeAreaInsets.bottom
            
            chatView_constraint_bottom.constant = bottom
            UIView.animate(withDuration: duration) {
                self.layoutIfNeeded()
            } completion: { _ in
                
            }

        }
        
    }
    @objc func keyboardWillHide(_ noti: NSNotification) {
        let userInfo = noti.userInfo!
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        if chatView_constraint_bottom.constant != 0 {
            chatView_constraint_bottom.constant = 0
        }
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        } completion: { _ in
            
        }

    }
    
    @objc func appDidBackground() {
        print("== 0_0 == AppDidBackGround")
    }
    @objc func appWillForeground() {
        print("== 0_0 == AppWillForeground")
    }
    
}
