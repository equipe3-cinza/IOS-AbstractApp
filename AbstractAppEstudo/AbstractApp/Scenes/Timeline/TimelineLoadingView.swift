//
//  TimelineLoadingView.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import UIKit
import SnapKit

class TimelineLoadingView: UIView {
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Carregando..."
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.startAnimating()
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("esta view nao pode ser inicializada")
    }
}

extension TimelineLoadingView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(loadingLabel)
        addSubview(loadingIndicator)
    }
    
    func buildViewConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loadingLabel.snp.makeConstraints { make in
            make.top.equalTo(loadingIndicator.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func additionalConfig() {
        self.backgroundColor = .white
    }
}

