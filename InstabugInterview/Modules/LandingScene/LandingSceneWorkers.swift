//
//  LandingSceneWorkers.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import InstabugNetworkClient

class LandingSceneWorkers {

    func get(url: URL, _ completionHandler: @escaping ((_ finished: Bool) -> Void)) {
        NetworkClient.shared.get(url) { data in
            completionHandler(true)
        }
    }

    func post(url: URL, data: Data?, _ completionHandler: @escaping ((_ finished: Bool) -> Void)) {
        NetworkClient.shared.post(url, payload: data) { data in
            completionHandler(true)
        }
    }

    func put(url: URL, data: Data?, _ completionHandler: @escaping ((_ finished: Bool) -> Void)) {
        NetworkClient.shared.put(url, payload: data) { data in
            completionHandler(true)
        }
    }

    func delete(url: URL, _ completionHandler: @escaping ((_ finished: Bool) -> Void)) {
        NetworkClient.shared.delete(url) { data in
            completionHandler(true)
        }
    }
}
