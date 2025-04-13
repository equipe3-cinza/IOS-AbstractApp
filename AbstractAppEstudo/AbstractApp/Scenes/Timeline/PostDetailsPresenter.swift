import Foundation

protocol PostDetailsViewControllerProtocol: AnyObject {
    // Protocol requirements will be added as needed
}

class PostDetailsPresenter {
    private weak var viewController: PostDetailsViewControllerProtocol?
    private let router: PostDetailsRouter
    
    init(viewController: PostDetailsViewControllerProtocol?, router: PostDetailsRouter) {
        self.viewController = viewController
        self.router = router
    }
} 