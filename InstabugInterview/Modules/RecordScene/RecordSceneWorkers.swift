//
//  RecordSceneWorkers.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import InstabugNetworkClient

class RecordSceneWorkers {

    func getAllRequests(_ completionHandler: @escaping (([RequestModel]) -> Void)) {
        NetworkClient.shared.allNetworkRequests { requests in
            completionHandler(requests)
        }
    }
}
