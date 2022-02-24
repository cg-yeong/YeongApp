//
//	YeongSwitchButton.swift
//	YeongApp
//

import Foundation
import UIKit

protocol YeongSwitchButtonDelegate: AnyObject {
    func isOnValueChange(isOn: Bool)
}

class YeongSwitchButton: UIButton {
    typealias SwitchColor = (bar: UIColor, circle: UIColor)
    
    private var barView: UIView!
    private var circleView: UIView!
    
    var onColor: SwitchColor = (#colorLiteral(red: 0.9960784314, green: 0.9058823529, blue: 0.9058823529, alpha: 1), #colorLiteral(red: 0.8901960784, green: 0.3137254902, blue: 0.3254901961, alpha: 1)) {
        didSet {
            if isOn {
                self.barView.backgroundColor = self.onColor.bar
                self.circleView.backgroundColor = self.onColor.circle
            }
        }
    }
    var offColor: SwitchColor = (#colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1), #colorLiteral(red: 0.7709601521, green: 0.7709783912, blue: 0.7709685564, alpha: 1)) {
        didSet {
            if !isOn {
                self.barView.backgroundColor = self.offColor.bar
                self.circleView.backgroundColor = self.offColor.circle
            }
        }
    }
        
    var isOn: Bool = false {
        didSet { self.changeState() }
    }
    
    // switch Animation True or False when `isOn` value Change
    private var isAnimated: Bool = false
    
    // for switch moving animation
    var animationDuration: TimeInterval = 0.25
    
    // bar - Margin Top, Bottom
    var barViewTopBottomMargin: CGFloat = 5
    
    weak var delegate: YeongSwitchButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonInit(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buttonInit(frame: frame)
    }
    
    private func buttonInit(frame: CGRect) {
        let barViewHeight = frame.height - (barViewTopBottomMargin * 2)
        
        barView = UIView(frame: CGRect(x: 0, y: barViewTopBottomMargin, width: frame.width, height: barViewHeight))
        barView.backgroundColor = .white
        barView.layer.masksToBounds = true
        barView.layer.cornerRadius = barViewHeight / 2
        
        self.addSubview(barView)
        
        circleView = UIView(frame: CGRect(x: 0, y: 0, width: frame.height, height: frame.height))
        circleView.backgroundColor = .gray
        circleView.layer.masksToBounds = true
        circleView.layer.cornerRadius = frame.height / 2
        
        self.addSubview(circleView)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.setOn(on: !isOn, animated: true)
    }
    
    func setOn(on: Bool, animated: Bool) {
        self.isAnimated = animated
        self.isOn = on
    }
    
    func changeState() {
        var circleCenter: CGFloat = 0
        var barViewColor: UIColor = .clear
        var circleVeiwColor: UIColor = .clear
        
        if self.isOn {
            circleCenter = self.frame.width - (self.circleView.frame.width / 2)
            barViewColor = self.onColor.bar
            circleVeiwColor = self.onColor.circle
        } else {
            circleCenter = self.circleView.frame.width / 2
            barViewColor = self.offColor.bar
            circleVeiwColor = self.offColor.circle
        }
        
        let duration = self.isAnimated ? animationDuration : 0
        
        UIView.animate(withDuration: duration) {
            self.circleView.center.x = circleCenter
            self.barView.backgroundColor = barViewColor
            self.circleView.backgroundColor = circleVeiwColor
        } completion: { _ in
            self.delegate?.isOnValueChange(isOn: self.isOn)
            self.isAnimated = false
        }

    }
}
