//
//  UIStoryBoard.swift
//  Afrosdate
//
//  Created by Abdul Samad butt on 06/10/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
// MARK: StoryBoard
extension UIStoryboard {
    
    class func controller<T: UIViewController>() -> T {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: T.className) as! T
    }
}
// MARK: NSObject
extension NSObject {
    class var className: String {
        return String(describing: self.self)
    }
}
