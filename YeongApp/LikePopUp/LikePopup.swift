//
//	LikePopup.swift
//	YeongApp
//

import Foundation
import UIKit

class LikePopup: XibView {
    
    let goBack: UIButton = {
        let backBtn = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 30))
        backBtn.setTitle("뒤 로 가 기", for: .normal)
        backBtn.backgroundColor = .brown
        backBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        return backBtn
    }()
    
    let bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "fb_core_data_bg"))
        return imageView
    }()
    
    let iconsContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        // configure options
        let iconHeight: CGFloat = 38
        let padding: CGFloat = 6
        let imgs = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "angry")] // #imageLiteral(
//        let images = ["blue_like", "red_heart", "cry", "cry_laugh", "surprised", "angry"].map { UIImage(named: $0)}
        
        let arrangedSubviews = imgs.map({ (imgs) -> UIView in
            let imageView = UIImageView(image: imgs)
            imageView.layer.cornerRadius = iconHeight / 2
            
            // required for hit test
            imageView.isUserInteractionEnabled = true
            
            return imageView
//            let v = UIView()
//            v.backgroundColor = color
//            v.layer.cornerRadius = iconHeight / 2
//            return v
        })
        
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containerView.addSubview(stackView)
        
        let numIcons = CGFloat(arrangedSubviews.count)
        let width = numIcons * iconHeight + (numIcons + 1) * padding
        containerView.frame = CGRect(x: 0, y: 0, width: width, height: iconHeight + 2 * padding)
        containerView.layer.cornerRadius = containerView.frame.height / 2
        
        // shadow
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = containerView.frame
        
        
        return containerView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(bgImageView)
        self.addSubview(goBack)
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.frame  = UIScreen.main.bounds
        bgImageView.isUserInteractionEnabled = true
        
        setupLongPressGesture()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        App.presenter.contextView = nil
    }
    
    fileprivate func setupLongPressGesture() {
        bgImageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            handleGestureBegan(gesture: gesture)
            
        } else if gesture.state == .ended {
            
            // clean up the animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                self.iconsContainerView.transform = self.iconsContainerView.transform.translatedBy(x: 0, y: 50)
                self.iconsContainerView.alpha = 0
                
            }, completion: { _ in
                self.iconsContainerView.removeFromSuperview()
            })
            
            
        } else if gesture.state == .changed {
            handleGestureChange(gesture: gesture)
        }
    }
    
    
    fileprivate func handleGestureChange(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: iconsContainerView)
        print(pressedLocation)
        
        let fixedYLocation = CGPoint(x: pressedLocation.x, y: iconsContainerView.frame.height / 2)
        let hitTestView = iconsContainerView.hitTest(fixedYLocation, with: nil)
        
        
        if hitTestView is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
            } completion: { _ in
            }

        }
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        bgImageView.addSubview(iconsContainerView)
        
        let pressedLocation = gesture.location(in: bgImageView)
        print(pressedLocation)
        
        // transforamtion of the yellow box
        let centeredX = (bgImageView.frame.width - iconsContainerView.frame.width) / 2
        
        
        // alpha
        
        iconsContainerView.alpha = 0
        iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.iconsContainerView.alpha = 1
            self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
        } completion: { _ in
            
        }

    }
    
    @objc func close() {
        self.removeFromSuperview()
    }
}
