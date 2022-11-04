//
//	ScrollChatBaloon.swift
//	YeongApp
//

import Foundation
import UIKit
import SnapKit

class ScrollChatBaloon: UIView {
    
    private var labelOne = UILabel()
    
    private var labelTwo = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        privateInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        privateInit()
    }
    
    func privateInit() {
        
    }
}
