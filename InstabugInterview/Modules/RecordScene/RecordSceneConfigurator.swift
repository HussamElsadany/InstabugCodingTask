//
//  RecordSceneConfigurator.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

class RecordSceneConfigurator {

    static func configure() -> RecordSceneViewController {
        let viewController = RecordSceneViewController()
        let presenter = RecordScenePresenter(displayView: viewController)
        let interactor = RecordSceneInteractor(presenter: presenter)
        let router = RecordSceneRouter(controller: viewController)
        viewController.interactor = interactor
        viewController.dataStore = interactor
        viewController.router = router
        viewController.viewStore = presenter
        return viewController
    }
}
