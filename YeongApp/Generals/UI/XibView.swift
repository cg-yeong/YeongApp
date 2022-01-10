//
//  XibView.swift
//  YeongApp
//
//  Created by inforex on 2022/01/10.
//

import Foundation
import UIKit
import SwiftyJSON

class XibView: UIView {
    var viewData: JSON = JSON()
    var isInitialized = true
    var appearViewListener: (() -> Void)? = nil
    var removeViewListener: (() -> Void)? = nil
    
    required init(frame: CGRect, viewData: JSON) {
        super.init(frame: frame)
        self.viewData = viewData
        self.tag = 555
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        self.tag = 555
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
        self.tag = 555
    }
    
    private func commonInit() {
        // XibName = ModuelName.ClassName
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else { return }
        if let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(view)
        }
    }
    
    private func instantInit() {
        
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: .main)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let listender = appearViewListener, isInitialized {
            listender()
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        if let listender = removeViewListener {
            listender()
        }
    }
    
}
