//
//  LandingViewController.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import UIKit
import InstabugNetworkClient

protocol LandingSceneDisplayView: AnyObject {

}

class LandingViewController: UIViewController {

    var interactor: LandingSceneBusinessLogic!
    var dataStore: LandingSceneDataStore!
    var viewStore: LandingSceneViewStore!
    var router: LandingSceneRoutingLogic!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func checkRecordedSession(_ sender: Any) {
        router.routeToRecordScene()
    }

    @IBAction func sendNewRequest(_ sender: Any) {
        guard let url = URL(string: "https://httpbin.org/anything") else {
            return
        }

        NetworkClient.shared.get(url) { data in
            print(data)
        }

    }
}

extension LandingViewController: LandingSceneDisplayView {

}
