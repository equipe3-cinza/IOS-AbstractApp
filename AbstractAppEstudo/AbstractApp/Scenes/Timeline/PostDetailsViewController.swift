import UIKit

class PostDetailsViewController: UIViewController {
    
    private var post: Post
    private var interactor: PostDetailsInteractor?
    private var postDetailsView: PostDetailsView
    
    init(post: Post) {
        self.post = post
        self.postDetailsView = PostDetailsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = postDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViper()
    }
    
    private func setupView() {
        title = "Post Details"
        postDetailsView.configure(with: post)
    }
    
    private func initViper() {
        let router = PostDetailsRouter(viewController: self)
        let presenter = PostDetailsPresenter(viewController: self, router: router)
        interactor = PostDetailsInteractor(presenter: presenter)
    }
}

extension PostDetailsViewController: PostDetailsViewControllerProtocol {
    // Protocol conformance will be added as needed
} 