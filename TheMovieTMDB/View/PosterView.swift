//
//  PosterView.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 3.03.24.
//

import Foundation
import UIKit

class PosterView: UIImageView {

    private var ratingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .bold)
        label.backgroundColor = .orange
        label.numberOfLines = 1
        return label
    }()
    
    private var votesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .bold)
        label.backgroundColor = .orange
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        ratingStack.addArrangedSubview(ratingLabel)
        ratingStack.addArrangedSubview(votesCountLabel)
        addSubview(ratingStack)
    }
    
    func setData(rating: Double, votesCount: Int) {
        self.ratingLabel.text = " \(rating) / 10 ★ "
        self.votesCountLabel.text = " \(votesCount) votes "
        
    }
}

extension PosterView {
    private func setupConstraints() {
        ratingStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ratingStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ratingStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
}
