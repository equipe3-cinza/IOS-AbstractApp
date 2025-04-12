//
//  TimelineLoadingView.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import UIKit
import SnapKit

class TimelineLoadingView: UIView {
    
    // MARK: - Views
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
    
    // MARK: - Initializers
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
        didAddSubview(loadingIndicator)
    }
    
    func buildViewConstraints() {
        
    }
    
    func additionalConfig() {
        self.backgroundColor = .gray
    }
}
