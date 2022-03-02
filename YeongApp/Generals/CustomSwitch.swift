//
//	CustomSwitch.swift
//	YeongApp
//

import UIKit

@IBDesignable
class CustomSwitch: UIControl {
    
    // MARK: Public Properties
    public var animationDelay: Double = 0
    public var animationSpriteWithDamping: CGFloat = 0.7
    public var initialSpringVelocity: CGFloat = 0.5
    public var animationOptions: UIView.AnimationOptions = [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction]
    
    // switch
    @IBInspectable public var isOn: Bool = true
    @IBInspectable public var animationDuration: Double = 0.5
    
    @IBInspectable public var padding: CGFloat = 10 {
        didSet { self.layoutSubviews() }
    }
    
    
    @IBInspectable public var onTintColor: UIColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1) {
        didSet { self.setupUI() }
    }
    @IBInspectable public var offTintColor: UIColor = UIColor.lightGray {
        didSet { self.setupUI() }
    }
    @IBInspectable public var cornerRadius: CGFloat {
        get { return self.privateCornerRadius }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateCornerRadius = 0.5
            } else {
                privateCornerRadius = newValue
            }
        }
    }
    private var privateCornerRadius: CGFloat = 0.5 {
        didSet { self.layoutSubviews() }
    }
    
    // thumb properties
    @IBInspectable public var thumbTintColor: UIColor = UIColor.white {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    @IBInspectable public var thumbCornerRadius: CGFloat {
        get { return self.privateThumbCornerRadius }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateThumbCornerRadius = 0.5
            } else {
                privateThumbCornerRadius = newValue
            }
        }
    }
    private var privateThumbCornerRadius: CGFloat = 0.5 {
        didSet { self.layoutSubviews() }
    }
    @IBInspectable public var thumbSize: CGSize = .zero {
        didSet { self.layoutSubviews() }
    }
    
    // image
    @IBInspectable public var thumbImage: UIImage? = nil {
        didSet {
            guard let image = thumbImage else { return }
            thumbView.thumbImageView.image = image
        }
    }
    
    public var onImage: UIImage? {
        didSet {
            self.onImageView.image = onImage
            self.layoutSubviews()
        }
    }
    public var offImage: UIImage? {
        didSet {
            self.offImageView.image = offImage
            self.layoutSubviews()
        }
    }
    
    // thumb Shadow
    @IBInspectable public var thumbShadowColor: UIColor = UIColor.black {
        didSet { self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor }
    }
    @IBInspectable public var thumbShadowRadius: CGFloat = 1.5 {
        didSet { self.thumbView.layer.shadowRadius = self.thumbCornerRadius }
    }
    @IBInspectable public var thumbShadowOffset: CGSize = CGSize(width: 0.75, height: 2) {
        didSet { self.thumbView.layer.shadowOffset = self.thumbShadowOffset }
    }
    @IBInspectable public var thumbShadowOpacity: Float = 0.4 {
        didSet { self.thumbView.layer.shadowOpacity = self.thumbShadowOpacity }
    }
    
    // label
    public var labelOff: UILabel = UILabel()
    public var labelOn: UILabel = UILabel()
    
    public var areLabelsShown: Bool = false {
        didSet { self.setupUI() }
    }
    
    
    
    // No Editable
    public var thumbView = CustomSwitchThumbView(frame: .zero)
    public var onImageView: UIImageView = UIImageView(frame: .zero)
    public var offImageView: UIImageView = UIImageView(frame: .zero)
    public var onPoint: CGPoint = .zero // switch isOn = true -> thumb start point
    public var offPoint: CGPoint = .zero // swith isOn = false -> thumb start point
    public var isAnimating: Bool = false // Animation is Playing?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
}

extension CustomSwitch {
    
    // Functions
    
    func setupUI() {
        self.clear()
        self.clipsToBounds = false
        
        // configure thumb view
        self.thumbView.backgroundColor = self.thumbTintColor // default: white
        self.thumbView.isUserInteractionEnabled = false // only touch switch
        
        // thumbView shadow
        self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        self.thumbView.layer.shadowRadius = self.thumbShadowRadius
        self.thumbView.layer.shadowOpacity = self.thumbShadowOpacity
        self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        
        self.addSubview(self.thumbView) // thumb add on the switch
        self.addSubview(self.onImageView)
        self.addSubview(self.offImageView)
        
        self.setupLabels()
    }
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        self.animate()
        return true
    }
    
    
    
    private func animate() {
        self.isOn = !self.isOn
        self.isAnimating = true
        
        UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, usingSpringWithDamping: self.animationSpriteWithDamping, initialSpringVelocity: self.initialSpringVelocity, options: self.animationOptions) {
            
            self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            self.setOnOffImageFrame()
            
        } completion: { _ in
            
            self.isAnimating = false
            self.sendActions(for: .valueChanged)
        
        }
    }
    
    
    
    
}

extension CustomSwitch {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !self.isAnimating {
            // view layout work when not active animation
            self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor // switch background onoff color
            
            // thumb
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - self.padding * 2, height: self.bounds.size.height - self.padding * 2)
//            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - 2, height: self.bounds.height - 2)
            let yPosition = (self.bounds.size.height - thumbSize.height) / 2 // thumbCircle start Point.y
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPosition)
            self.offPoint = CGPoint(x: self.padding, y: yPosition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            
            // label frame
            if self.areLabelsShown {
                let labelWidth = self.bounds.width / 2 - self.padding * 2
                self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
                self.labelOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
            }
            
            // image
            // set to preservee aspect ratio of image in thumbView
            guard onImage != nil, offImage != nil else { return }
            
            let frameSize = thumbSize.width > thumbSize.height ? thumbSize.height * 0.7 : thumbSize.width * 0.7
            
            let onOffImageSize = CGSize(width: frameSize, height: frameSize)
            
            self.onImageView.frame.size = onOffImageSize
            self.offImageView.frame.size = onOffImageSize
            
            self.onImageView.center = CGPoint(x: self.onPoint.x + self.thumbSize.width / 2, y: self.onPoint.y + self.thumbSize.height / 2)
            self.offImageView.center = CGPoint(x: self.offPoint.x + self.thumbSize.width / 2, y: self.offPoint.y + self.thumbSize.height / 2)
            
            self.onImageView.alpha = self.isOn ? 1.0 : 0.0
            self.offImageView.alpha = self.isOn ? 0.0 : 1.0
            
        }
    }
    
}

// MARK: labels frame
extension CustomSwitch {
    
    fileprivate func setupLabels() {
        guard self.areLabelsShown else {
            self.labelOff.alpha = 0
            self.labelOn.alpha = 0
            return
        }
        
        self.labelOff.alpha = 1
        self.labelOn.alpha = 1
        
        let labelWidth = self.bounds.width / 2 - self.padding * 2
        self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
        self.labelOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
        self.labelOn.font = .boldSystemFont(ofSize: 12)
        self.labelOff.font = .boldSystemFont(ofSize: 12)
        self.labelOn.textColor = .white
        self.labelOff.textColor = .white
        
        self.labelOff.sizeToFit()
        self.labelOff.text = "꺼짐"
        self.labelOn.text = "켜기"
        self.labelOff.textAlignment = .center
        self.labelOn.textAlignment = .center
        
        self.insertSubview(self.labelOff, belowSubview: self.thumbView)
        self.insertSubview(self.labelOn, belowSubview: self.thumbView)
        
    }
    
}

extension CustomSwitch {
    
    fileprivate func setOnOffImageFrame() {
        guard onImage != nil, offImage != nil else { return }
        
        self.onImageView.center.x = self.isOn ? self.onPoint.x +  self.thumbView.frame.size.width / 2 : self.frame.width
        self.offImageView.center.x = self.isOn ? self.offPoint.x + self.thumbView.frame.size.width / 2 : 0
        
        self.onImageView.alpha = self.isOn ? 1.0 : 0.0
        self.offImageView.alpha = self.isOn ? 0.0 : 1.0
    }
}
