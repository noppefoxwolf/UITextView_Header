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
  private static let placeholderLabelTag: Int = 3212
  
  public var headerView: UIView? {
    get {
      return subviews.filter({ $0.tag == UITextView.headerViewTag }).first
    }
    set {
      headerView?.removeFromSuperview()
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
      footerView?.removeFromSuperview()
      guard let newValue = newValue else { return }
      newValue.tag = UITextView.footerViewTag
      addSubview(newValue)
      layoutFooterView()
    }
  }
  
  private var placeholderLabel: UILabel? {
    get {
      return subviews.filter({ $0.tag == UITextView.placeholderLabelTag }).first as? UILabel
    }
    set {
      placeholderLabel?.removeFromSuperview()
      guard let newValue = newValue else { return }
      newValue.tag = UITextView.placeholderLabelTag
      addSubview(newValue)
      layoutPlaceholderLabel()
    }
  }
  
  public var placeholder: NSAttributedString? {
    get { return _placeholder }
    set {
      _placeholder = newValue
      if let newValue = newValue {
        let label = UILabel()
        label.attributedText = newValue
        placeholderLabel = label
      } else {
        placeholderLabel = nil
      }
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
  
  private func layoutPlaceholderLabel() {
    if let placeholderLabel = placeholderLabel {
      placeholderLabel.sizeToFit()
      placeholderLabel.frame.origin = CGPoint(x: textContainerInset.left + textContainer.lineFragmentPadding,
                                              y: textContainerInset.top)
    }
    let isHidden = text.count > 0
    placeholderLabel?.isHidden = isHidden
  }
  
  private var _placeholder: NSAttributedString? {
    get {
      return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? NSAttributedString
    }
    set {
      objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
  
  public func textViewDidChange() {
    layoutFooterView()
    layoutPlaceholderLabel()
  }
}
