//
//	TextCell.swift
//	YeongApp
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

class TextCell: UICollectionViewCell {
    
    static let identifier = "TextCell"
    
    @IBOutlet weak var bubble: UIView!
    @IBOutlet weak var text: UILabel!
    
    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height) + 8
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
    func bind(with message: JSON) {
        
    }
    
}
