//
//  PresenterTrasnfer.swift
//  YeongApp
//
//  Created by inforex on 2022/01/10.
//

import Foundation
import SwiftyJSON
import UIKit

/**
 * iOS에서의 화면전환 개념
 * 1. ViewController 의 View 위에 다른 View를 가져와 바꿔치기하기
 * 2. ViewController 에서 다른 ViewController를 호출해서 화면 전환하기
 * 3. Navigation Controller 를 사용하여 화면 전환하기
 * 4. 화면 전환용 객체 Segue를 사용하여 화면 전환하기
 */

protocol PresenterTransfer where Self: PresenterDelegate {}
extension PresenterTransfer {
    
}
