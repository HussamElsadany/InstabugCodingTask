//
//  LandingViewController.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import UIKit
import InstabugNetworkClient

protocol LandingSceneDisplayView: AnyObject {
    func displayFinishRequests()
}

class LandingViewController: UIViewController {

    var interactor: LandingSceneBusinessLogic!
    var dataStore: LandingSceneDataStore!
    var viewStore: LandingSceneViewStore!
    var router: LandingSceneRoutingLogic!

    @IBOutlet private weak var randomRequestButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func checkRecordedSession(_ sender: Any) {
        router.routeToRecordScene()
    }

    @IBAction func sendSingleRequest(_ sender: Any) {
        interactor.sendSingleRequest()
    }

    @IBAction func sendRandomRequests(_ sender: Any) {
        randomRequestButton.startLoading()
        interactor.sendRandomRequests()
    }
}

extension LandingViewController: LandingSceneDisplayView {

    func displayFinishRequests() {
        randomRequestButton.stopLoading()
    }
}
