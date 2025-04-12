//
//  TimelineView.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import UIKit

class TimelineView: UIView {
    
    // MARK: - Initializers
    private lazy var loadingView = TimelineLoadingView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("esta view nao pode ser inicializada")
    }
}
