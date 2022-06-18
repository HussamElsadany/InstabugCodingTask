//
//  RecordSceneViewController.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import UIKit

protocol RecordSceneDisplayView: AnyObject {
    func displayRequests(viewModel: RecordScene.Request.ViewModel)
}

class RecordSceneViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!


    var interactor: RecordSceneBusinessLogic!
    var dataStore: RecordSceneDataStore!
    var viewStore: RecordSceneViewStore!
    var router: RecordSceneRoutingLogic!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.fetchAllRequests()
    }

    private func setupUI() {
        tableView.registerCell(RecordTableViewCell.self)
    }
}

extension RecordSceneViewController: RecordSceneDisplayView {

    func displayRequests(viewModel: RecordScene.Request.ViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension RecordSceneViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewStore.requestsViewModel?.requests.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecordTableViewCell = tableView.dequeueReusableCell()
        if let requestViewModel = viewStore.requestsViewModel?.requests[indexPath.row] {
            cell.configureCell(requestViewModel)
        }
        return cell
    }
}
