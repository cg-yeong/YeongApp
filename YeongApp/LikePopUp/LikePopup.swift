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
    
    let emoteContainerView: UIView = {
       let containerView = UIView()
        containerView.backgroundColor = .white
        
        // configure
        let emoHeight: CGFloat = 38
        let padding: CGFloat = 6
        let imgs = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "angry")]
        
        let arrangedSubviews = imgs.map { (img) -> UIButton in
            let imgBtn = UIButton(type: .custom)
            imgBtn.setImage(img, for: .normal)
            imgBtn.addTarget(self, action: #selector(setImgBtn(sender:)), for: .touchUpInside)
            
            return imgBtn
        }
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containerView.addSubview(stackView)
        
        let width = CGFloat(arrangedSubviews.count) * emoHeight + (CGFloat(arrangedSubviews.count) + 1) * padding
        containerView.frame = CGRect(x: 0, y: 0, width: width, height: emoHeight + 2 * padding)
        containerView.layer.cornerRadius = containerView.frame.height / 2
        
        // shadow
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = containerView.frame
        
        return containerView
    }()
    
    let addEmoteBtn: UIButton = {
        
        let btn = UIButton(frame: CGRect(x: 50, y: 250, width: 50, height: 50))
        btn.setImage(UIImage(named: "blue_like"), for: .normal)
        btn.addTarget(self, action: #selector(addEmote), for: .touchUpInside)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(bgImageView)
        self.addSubview(goBack)
        self.addSubview(addEmoteBtn)
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.frame  = UIScreen.main.bounds
        bgImageView.isUserInteractionEnabled = true
        
        setupLongPressGesture()
        setEmoteTap()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        App.presenter.contextView = nil
    }
    
    @objc func setImgBtn(sender: UIButton) {
        let img = sender.image(for: .normal)
        sender.setImage(UIImage(named: "btnRadOn"), for: .highlighted)
        self.addEmoteBtn.setImage(img, for: .normal)
        
    }
    @objc func close() {
        self.removeFromSuperview()
    }
    
    @objc func addEmote() {
        print("감표")
        emoteBegan()
    }
    
    
}
