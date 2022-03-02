//
//	CustomSwitchThumbView.swift
//	YeongApp
//

import UIKit

class CustomSwitchThumbView: UIView {
    
    fileprivate(set) var thumbImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(thumbImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(thumbImageView)
    }
}

extension CustomSwitchThumbView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.thumbImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.thumbImageView.layer.cornerRadius = self.layer.cornerRadius
        self.thumbImageView.clipsToBounds = self.clipsToBounds
    }
}
