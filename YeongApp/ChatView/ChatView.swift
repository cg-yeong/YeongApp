//
//  ChatView.swift
//  YeongApp
//
//  Created by inforex on 2022/01/10.
//

import Foundation
import UIKit

class ChatView: UIView {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var floatingView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "ChatView", bundle: .main)
        guard let xibView = nib.instantiate(withOwner: self, options: [:]).first as? UIView else { return }
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }
    
    @IBAction func closeChatView(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
}
