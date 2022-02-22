//
//	LikePopup+Emote.swift
//	YeongApp
//

import UIKit

extension LikePopup {
    
    /*
     Long Press Gesture Emote Animation
     */
    internal func setupLongPressGesture() {
        bgImageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    @objc internal func handleLongPress(gesture: UILongPressGestureRecognizer) {
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
    
    internal func handleGestureChange(gesture: UILongPressGestureRecognizer) {
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
    
    internal func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
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
    
    /*
     set Emote Additional Button
     */
    internal func emoteBegan() {
        
        bgImageView.addSubview(emoteContainerView)
        
        emoteContainerView.alpha = 0
        emoteContainerView.transform = CGAffineTransform(translationX: addEmoteBtn.frame.minX, y: addEmoteBtn.frame.maxY + emoteContainerView.frame.height + 8)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.emoteContainerView.alpha = 1
            self.emoteContainerView.transform = CGAffineTransform(translationX: self.addEmoteBtn.frame.minX, y: self.addEmoteBtn.frame.maxY + 8)
        }, completion: nil)
        
    }
    
    internal func setEmoteTap() {
        bgImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEmote(gesture:))))
    }
    
    @objc internal func handleEmote(gesture: UITapGestureRecognizer) {
        print("배경 클릭")
        let pressedEmoteLocation = gesture.location(in: emoteContainerView)
        let hitTestView = emoteContainerView.hitTest(pressedEmoteLocation, with: nil)
        
        if hitTestView is UIButton {
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromLeft, animations: {
                let _ = self.emoteContainerView.subviews.first
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.emoteContainerView.transform = self.emoteContainerView.transform.translatedBy(x: 0, y: self.emoteContainerView.frame.height)
            self.emoteContainerView.alpha = 0
        } completion: { _ in
            self.emoteContainerView.removeFromSuperview()
        }

    }
}
