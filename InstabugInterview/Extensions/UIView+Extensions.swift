//
//  UIView+Extensions.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import UIKit

@IBDesignable extension UIView {

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIView {

    func pinItemToEdges(item: UIView, constants: [CGFloat] = [0, 0, 0, 0]) {
        item.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .trailing, .bottom, .leading]
        activateLayoutAttributes(attributes, for: item, constants: constants)
    }

    func activateLayoutAttributes(_ attributes: [NSLayoutConstraint.Attribute], for item: UIView, constants: [CGFloat] = [0, 0, 0, 0]) {
        var index = -1
        NSLayoutConstraint.activate(attributes.map {
            index += 1
            return NSLayoutConstraint(item: item, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: constants[index])
        })
    }
}
