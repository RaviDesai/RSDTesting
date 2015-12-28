//
//  UIViewExtensions.swift
//  Pods
//
//  Created by Ravi Desai on 12/28/15.
//
//

import UIKit

public extension UIView {
    public func embeddedView<T: UIView>() -> T? {
        return embeddedView(nil)
    }

    public func embeddedView<T: UIView>(tag: Int?) -> T? {
        var result: T?
        for subview in self.subviews {
            result = subview as? T
            if (result == nil) {
                result = subview.embeddedView()
            } else {
                if tag == nil { break }
                if result?.tag == tag { break }
            }
        }
        return result
    }

}
