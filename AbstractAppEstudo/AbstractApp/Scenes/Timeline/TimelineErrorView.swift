//
//  TimelineErrorView.swift
//  AbstractApp
//
//  Created by user272851 on 4/12/25.
//

import UIKit
import SnapKit

protocol TimelineErrorViewDelegate: AnyObject {
    func didTapRetry()
}

class TimelineErrorView: UIView {
    
    weak var delegate: TimelineErrorViewDelegate?
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Ocorreu um erro ao carregar os posts"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tentar novamente", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(handleRetry), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func handleRetry() {
        delegate?.didTapRetry()
    }
}

extension TimelineErrorView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(errorLabel)
        addSubview(retryButton)
    }
    
    func buildViewConstraints() {
        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        retryButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        backgroundColor = .white
    }
}
