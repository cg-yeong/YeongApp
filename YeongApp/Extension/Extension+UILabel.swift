//
//	Extension+UILabel.swift
//	YeongApp
//

import Foundation
import UIKit

extension UILabel {
    
    /**
     자간 조절하기
        - NSMutableAttributedString : 텍스트 관련 부분속성  ( visual Style, HyperLink .. etc) 변경가능한 문자열
     */
    func setCharacterSpacing(_ spacing : CGFloat) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(NSMutableAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    /**
     행간 조절 하기
     
        - NSMutableParagraphStyle : 단락 스타일 속성값 변경위한 개체
        !! 속성 문자열에 추가한 후 단락 스타일 개체를 변경하면 앱이 충돌날 수 도 있다
        lineSpacing : 행간거리
        lineHeightMultiple : 라인 높이 배수
        - NSMutableAttributedString : 텍스트 관련 부분속성 ( visual Style, HyperLink .. etc) 있는 변경가능한 문자열
        NSRange : 문자열의 문자나 배열의 개체와 같이 시리즈의 일부를 설명하는데 사용되는 구조
     */
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
}
