//
//  RecordScenePresenter.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import InstabugNetworkClient

protocol RecordScenePresentationLogic: AnyObject {
    func presentAllRequests(_ requests: [RequestModel])
}

protocol RecordSceneViewStore: AnyObject {
    var requestsViewModel: RecordScene.Request.ViewModel? { get set }
}

class RecordScenePresenter: RecordScenePresentationLogic, RecordSceneViewStore {

    // MARK: Stored Properties
    weak var displayView: RecordSceneDisplayView?

    var requestsViewModel: RecordScene.Request.ViewModel?

    // MARK: Initializers
    required init(displayView: RecordSceneDisplayView) {
        self.displayView = displayView
    }
}

extension RecordScenePresenter {

    func presentAllRequests(_ requests: [RequestModel]) {
        let requestsViewModels = requests.map {
            return self.generateRequest($0)
        }
        requestsViewModel = RecordScene.Request.ViewModel(requests: requestsViewModels)
        displayView?.displayRequests(viewModel: requestsViewModel!)
    }
}

private extension RecordScenePresenter {

    func generateRequest(_ request: RequestModel) -> RecordScene.Request.Request {

        let requestStatus: RequestStatus = request.response?.error == nil ? .success : .fail
        var desc: String = ""

        switch requestStatus {
        case .success:
            desc = String(format: "(%i) OK", request.response?.success?.code ?? 0)
        case .fail:
            desc = String(format: "%i %@", request.response?.error?.code ?? 0, request.response?.error?.domain ?? "")
        }

        var requestData: String?
        var responseData: String?

        if let data = request.payload {
            requestData = String(format: "Request Data Size: %d", data.count)
        }

        if let data = request.response?.success?.payload {
            responseData = String(format: "Response Data Size: %d", data.count)
        }

        return RecordScene.Request.Request(status: requestStatus,
                                           url: request.url ?? "",
                                           desc: desc,
                                           method: request.method ?? "",
                                           requestData: requestData,
                                           responseData: responseData)
    }
}
