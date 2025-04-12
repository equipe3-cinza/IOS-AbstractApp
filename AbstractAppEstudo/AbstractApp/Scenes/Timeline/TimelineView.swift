//
//  TimelineView.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import UIKit

protocol TimelineViewDelegate: AnyObject {
    func timelineViewDidTapRetry()
}

class TimelineView: UIView {
    
    // MARK: - Properties
    weak var delegate: TimelineViewDelegate?
    private var posts: [Post] = []
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        table.delegate = self
        table.dataSource = self
        table.isHidden = true
        return table
    }()
    
    private lazy var loadingView: TimelineLoadingView = {
        let view = TimelineLoadingView()
        view.isHidden = true
        return view
    }()
    
    private lazy var errorView: TimelineErrorView = {
        let view = TimelineErrorView()
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("esta view nao pode ser inicializada")
    }
}

extension TimelineView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(errorView)
    }
    
    func buildViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        backgroundColor = .white
    }
}

extension TimelineView {
    func showLoading() {
        loadingView.isHidden = false
        errorView.isHidden = true
        tableView.isHidden = true
    }
    
    func showError() {
        loadingView.isHidden = true
        errorView.isHidden = false
        tableView.isHidden = true
    }
    
    func showContent(posts: [Post]) {
        self.posts = posts
        loadingView.isHidden = true
        errorView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
}

extension TimelineView: TimelineErrorViewDelegate {
    func didTapRetry() {
        delegate?.timelineViewDidTapRetry()
    }
}

extension TimelineView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let post = posts[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = post.title
        content.secondaryText = post.body
        content.secondaryTextProperties.numberOfLines = 2
        cell.contentConfiguration = content
        
        return cell
    }
}
