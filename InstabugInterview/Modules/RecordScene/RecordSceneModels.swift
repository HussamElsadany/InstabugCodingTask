//
//  RecordSceneModels.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

public enum RequestStatus {
    case success
    case fail
}

enum RecordScene {
    enum Request { }
}

extension RecordScene.Request {

    struct Request {
        let status: RequestStatus
        let url: String
        let desc: String
        let method: String
        let requestData: String?
        let responseData: String?
    }

    struct ViewModel {
        var requests: [Request]
    }
}
