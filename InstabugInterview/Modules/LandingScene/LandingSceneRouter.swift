//
//  LandingSceneRouter.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import UIKit

protocol LandingSceneRoutingLogic: AnyObject {
    typealias Controller = LandingSceneDisplayView & LandingViewController

    func routeToRecordScene()
}

class LandingSceneRouter {

    // MARK: Stored Properties
    var viewController: Controller?

    // MARK: Initializers
    required init(controller: Controller?) {
        self.viewController = controller
    }
}

extension LandingSceneRouter: LandingSceneRoutingLogic {

    func routeToRecordScene() {
        let recordViewController = RecordSceneConfigurator.configure()
        viewController?.navigationController?.pushViewController(recordViewController, animated: true)
    }
}
