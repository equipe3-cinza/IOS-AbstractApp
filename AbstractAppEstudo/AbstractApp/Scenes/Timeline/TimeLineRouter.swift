//
//  TimeLineRouter.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import Foundation
import UIKit

class TimelineRouter {
    
    private weak var viewController: TimelineViewController?
    
    init(viewController: TimelineViewController?) {
        self.viewController = viewController
    }
    
    func navigateToPostDetails(post: Post) {
        let postDetailsVC = PostDetailsViewController(post: post)
        viewController?.navigationController?.pushViewController(postDetailsVC, animated: true)
    }
}
