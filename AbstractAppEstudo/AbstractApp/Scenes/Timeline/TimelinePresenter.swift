//
//  TimelinePresenter.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import Foundation

protocol TimelineViewControllerProtocol: AnyObject {
    func showLoading()
    func showError()
    func showContent(posts: [Post])
}

class TimelinePresenter {
    private weak var viewController: TimelineViewControllerProtocol?
    private let router: TimelineRouter
    
    init(viewController: TimelineViewControllerProtocol?, router: TimelineRouter) {
        self.viewController = viewController
        self.router = router
    }
}

extension TimelinePresenter {
    func startLoading() {
        viewController?.showLoading()
    }
    
    func handleError() {
        viewController?.showError()
    }
    
    func handleSuccess(posts: [Post]) {
        viewController?.showContent(posts: posts)
    }
}
