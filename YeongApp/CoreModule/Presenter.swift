//
//  Presenter.swift
//  YeongApp
//
//  Created by inforex on 2022/01/10.
//

import Foundation
import UIKit

class Presenter: PresenterDelegate, PresentedView, PresenterTransfer  {
    
    var mainVC: UIViewController!
    var contextView: XibView!
    
    enum OnController {
        case navigationView
        case visibleView
        case topView
    }
    
    var visibleViewController: UIViewController? {
        get { return visibleViewController() }
    }
    
    var navigationViewController: UINavigationController? {
        get { return navigationViewController() }
    }
    
    var topViewController: UIViewController? {
        get { return navigationTopViewController() }
    }
    
    func onViewController(_ on: OnController) -> UIViewController? {
        switch on {
        case .navigationView    : return navigationViewController()
        case .visibleView       : return visibleViewController()
        case .topView           : return navigationTopViewController()
        }
    }
}

protocol PresenterDelegate {
    var visibleViewController: UIViewController? { get }
    var navigationViewController: UINavigationController? { get }
    var topViewController: UIViewController? { get }
    func onViewController(_ on: Presenter.OnController) -> UIViewController?
}

protocol PresentedView {}
extension PresentedView {
    
    /// 현재 보이는 ViewController를 얻는 함수, Navigation이나 TabBar에서도 접근 가능
    fileprivate func visibleViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        // Navigation
        if let nav = base as? UINavigationController {
            return visibleViewController(base: nav.visibleViewController)
        }
        
        // TabBar - Selected : 탭바 구조는 탭바 위에 여러개 뷰컨이 달려있는 형태 비슷함
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return visibleViewController(base: selected)
            }
        }
        
        // Present
        if let presented = base?.presentedViewController {
            return visibleViewController(base: presented)
        }
        return base
    }
    
    // Navigation ViewController 전체?
    fileprivate func navigationViewController() -> UINavigationController? {
        return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }
    
    // Navigation ViewController 중 제일 위에 TopViewController를 가져옴
    fileprivate func navigationTopViewController() -> UIViewController? {
        return (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController)?.topViewController
    }
}
