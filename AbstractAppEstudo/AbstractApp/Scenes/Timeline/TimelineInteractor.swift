//
//  TimelineInteractor.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import Foundation


class TimelineInteractor {
    
    private let service: TimelineService
    private let presenter: TimelinePresenter
    
    init(service: TimelineService, presenter: TimelinePresenter) {
        self.service = service
        self.presenter = presenter
    }
}

extension TimelineInteractor {
    func loadTimeline() {
        presenter.startLoading()
        service.fetchTimeline { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let posts):
                self.presenter.handleSuccess(posts: posts)
            case .failure:
                self.presenter.handleError()
            }
        }
    }
}
