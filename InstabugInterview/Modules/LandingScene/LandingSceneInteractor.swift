//
//  LandingSceneInteractor.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

protocol LandingSceneBusinessLogic: AnyObject {

}

protocol LandingSceneDataStore: AnyObject {

}

class LandingSceneInteractor: LandingSceneBusinessLogic, LandingSceneDataStore {

    // MARK: Stored Properties
    let presenter: LandingScenePresentationLogic

    // MARK: Initializers
    required init(presenter: LandingScenePresentationLogic) {
        self.presenter = presenter
    }
}

extension LandingSceneInteractor {

}
