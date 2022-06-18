//
//  UITableView+Extensions.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import UIKit

extension UITableView {

    func registerCell(_ identifierName: String) {
        self.register(UINib(nibName: identifierName, bundle: nil), forCellReuseIdentifier: identifierName)
    }

    func registerCell(_ cell: UITableViewCell.Type) {
        let cellIdentifier = String(describing: cell.self)
        self.registerCell(cellIdentifier)
    }

    func dequeueReusableCell<T>() -> T {
        let cellIdentifier = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: cellIdentifier) as! T
    }
}
