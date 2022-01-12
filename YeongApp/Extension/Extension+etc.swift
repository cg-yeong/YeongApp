//
//	Extension+etc.swift
//	YeongApp
//

import Foundation
import UIKit

extension UINavigationController {
    // pushViewController(_ viewController:, animated:) NO Completion
    // pushViewController + completionHandler
    public func pushViewController(viewController: UIViewController,
                                   animated: Bool,
                                   completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
