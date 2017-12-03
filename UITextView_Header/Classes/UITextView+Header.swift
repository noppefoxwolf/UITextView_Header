//
//  UITextView+Header.swift
//  UITextView_Header
//
//  Created by Tomoya Hirano on 2017/12/03.
//

import UIKit

private var AssociatedObjectHandle: UInt8 = 0
extension UITextView {
  private static let headerViewTag: Int = 6954
  private static let headerViewSpaceAssociatedObjectHandle: Int8 = 0
  
  public var headerView: UIView? {
    get {
      return subviews.filter({ $0.tag == UITextView.headerViewTag }).first
    }
    set {
      newValue?.removeFromSuperview()
      guard let newValue = newValue else { return }
      newValue.tag = UITextView.headerViewTag
      let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
      let systemLayoutSize = newValue.systemLayoutSizeFitting(fittingSize)
      newValue.frame = CGRect(x: 0,
                              y: -(systemLayoutSize.height + headerViewSpace),
                              width: bounds.width,
                              height: systemLayoutSize.height)
      addSubview(newValue)
    }
  }
  
  public var headerViewSpace: CGFloat {
    get {
      return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? CGFloat ?? 0.0
    }
    set {
      objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}