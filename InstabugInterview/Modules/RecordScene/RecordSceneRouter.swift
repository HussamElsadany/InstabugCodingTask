//
//  RecordSceneRouter.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

protocol RecordSceneRoutingLogic: AnyObject {
    typealias Controller = RecordSceneDisplayView & RecordSceneViewController
}

class RecordSceneRouter {

    // MARK: Stored Properties
    var viewController: Controller?

    // MARK: Initializers
    required init(controller: Controller?) {
        self.viewController = controller
    }
}

extension RecordSceneRouter: RecordSceneRoutingLogic {

}
