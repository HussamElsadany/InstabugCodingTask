//
//  LandingScenePresenter.swift
//  InstabugInterview
//
//  Created by Hussam Elsadany on 18/06/2022.
//

protocol LandingScenePresentationLogic: AnyObject {

}

protocol LandingSceneViewStore: AnyObject {

}

class LandingScenePresenter: LandingScenePresentationLogic, LandingSceneViewStore {

    // MARK: Stored Properties
    weak var displayView: LandingSceneDisplayView?

    // MARK: Initializers
    required init(displayView: LandingSceneDisplayView) {
        self.displayView = displayView
    }
}

extension LandingScenePresenter {

}
