//
//  RecordTableViewCell.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import UIKit

class RecordTableViewCell: UITableViewCell {


    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var methodLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!

    func configureCell(_ viewModel: RecordScene.Request.Request) {
        methodLabel.text = viewModel.method
        urlLabel.text = viewModel.url
        statusLabel.text = viewModel.desc
        switch viewModel.status {
        case .success:
            statusView.backgroundColor = .green
        case .fail:
            statusView.backgroundColor = .red
        }
    }
}
