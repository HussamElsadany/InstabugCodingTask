//
//  LandingSceneConfigurator.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

class LandingSceneConfigurator {

    static func configure() -> LandingViewController {
        let viewController = LandingViewController()
        let presenter = LandingScenePresenter(displayView: viewController)
        let interactor = LandingSceneInteractor(presenter: presenter)
        let router = LandingSceneRouter(controller: viewController)
        viewController.interactor = interactor
        viewController.dataStore = interactor
        viewController.router = router
        viewController.viewStore = presenter
        return viewController
    }
}
