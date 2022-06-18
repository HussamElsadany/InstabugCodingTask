//
//  RecordSceneInteractor.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import InstabugNetworkClient

protocol RecordSceneBusinessLogic: AnyObject {
    func fetchAllRequests()
}

protocol RecordSceneDataStore: AnyObject {
    var requests: [RequestModel] { get set }
}

class RecordSceneInteractor: RecordSceneBusinessLogic, RecordSceneDataStore {

    // MARK: Stored Properties
    let presenter: RecordScenePresentationLogic

    var requests: [RequestModel] = []

    private let worker = RecordSceneWorkers()

    // MARK: Initializers
    required init(presenter: RecordScenePresentationLogic) {
        self.presenter = presenter
    }
}

extension RecordSceneInteractor {

    func fetchAllRequests() {
        worker.getAllRequests { requests in
            self.requests = requests
            self.presenter.presentAllRequests(requests)
        }
    }
}
