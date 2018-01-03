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
  private static let footerViewTag: Int = 9794
  
  public var headerView: UIView? {
    get {
      return subviews.filter({ $0.tag == UITextView.headerViewTag }).first
    }
    set {
      newValue?.removeFromSuperview()
      guard let newValue = newValue else { return }
      newValue.tag = UITextView.headerViewTag
      addSubview(newValue)
      layoutHeaderView()
    }
  }
  
  public var footerView: UIView? {
    get {
      return subviews.filter({ $0.tag == UITextView.footerViewTag }).first
    }
    set {
      newValue?.removeFromSuperview()
      guard let newValue = newValue else { return }
      newValue.tag = UITextView.footerViewTag
      addSubview(newValue)
      layoutFooterView()
    }
  }
  
  private func layoutHeaderView() {
    if let headerView = headerView {
      let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
      let systemLayoutSize = headerView.systemLayoutSizeFitting(fittingSize)
      if headerViewSpace < 0 {
        textContainerInset.top = abs(headerViewSpace)
      }
      headerView.frame = CGRect(x: 0,
                              y: -(systemLayoutSize.height + headerViewSpace),
                              width: bounds.width,
                              height: systemLayoutSize.height)
    }
  }
  
  private func layoutFooterView() {
    if let footerView = footerView {
      footerView.frame = bounds
      let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
      footerView.frame.size = footerView.systemLayoutSizeFitting(fittingSize)
      footerView.frame.origin.y = contentSize.height + footerViewSpace
    }
  }
  
  public var headerViewSpace: CGFloat {
    get {
      return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? CGFloat ?? 0.0
    }
    set {
      objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      layoutHeaderView()
    }
  }
  
  public var footerViewSpace: CGFloat {
    get {
      return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? CGFloat ?? 0.0
    }
    set {
      objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      layoutFooterView()
    }
  }
  
  public func textViewDidChange(_ textView: UITextView) {
    layoutFooterView()
  }
}
