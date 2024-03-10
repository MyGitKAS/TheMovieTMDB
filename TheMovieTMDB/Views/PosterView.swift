//
//  PosterView.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 3.03.24.
//

import UIKit

final class PosterView: UIImageView {

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
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.backgroundColor = .orange
        label.numberOfLines = 1
        return label
    }()
    
    private var votesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .bold)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
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
    }
    
    private func setupView() {
        ratingStack.addArrangedSubview(ratingLabel)
        ratingStack.addArrangedSubview(votesCountLabel)
        addSubview(ratingStack)
    }
    
    func setData(rating: String, votesCount: Int) {
        self.ratingLabel.text = " \(rating) / 10 ★ "
        self.votesCountLabel.text = " \(votesCount) votes "
    }
}

extension PosterView {
    private func setupConstraints() {
        
        ratingStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            ratingStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            ratingStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            self.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}
