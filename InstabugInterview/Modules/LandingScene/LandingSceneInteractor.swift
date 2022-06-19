//
//  LandingSceneInteractor.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import Foundation

protocol LandingSceneBusinessLogic: AnyObject {
    func sendSingleRequest()
    func sendRandomRequests()
}

protocol LandingSceneDataStore: AnyObject {

}

class LandingSceneInteractor: LandingSceneBusinessLogic, LandingSceneDataStore {

    // MARK: Stored Properties
    let presenter: LandingScenePresentationLogic

    private let worker = LandingSceneWorkers()

    private let anythingURL = URL(string: "https://httpbin.org/anything")!
    private let wrongURL = URL(string: "https://njeringpniernpgnure.org/anything")!

    // MARK: Initializers
    required init(presenter: LandingScenePresentationLogic) {
        self.presenter = presenter
    }
}

extension LandingSceneInteractor {

    func sendSingleRequest() {
        worker.get(url: anythingURL) { finished in }
    }

    func sendRandomRequests() {

        let data = "Any Data".data(using: .utf8)

        self.worker.get(url: self.anythingURL) { finished in

            self.worker.post(url: self.anythingURL, data: data) { finished in

                self.worker.put(url: self.anythingURL, data: nil) { finished in

                    self.worker.delete(url: self.anythingURL) { finished in

                        self.worker.get(url: self.wrongURL) { finished in

                            self.worker.get(url: self.anythingURL) { finished in

                                self.presenter.presentStopLoading()

                            }
                        }
                    }
                }
            }
        }
    }
}
