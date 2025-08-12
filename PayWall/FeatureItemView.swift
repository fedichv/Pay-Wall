//
//  FeatureItemView.swift
//  PayWall
//
//  Created by Владимир Федичев on 8/12/25.
//
import UIKit

final class FeatureItemView: UIView {
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "checkbox-marked"))
        iv.tintColor = .systemGreen
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .lightGray
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private let textStack = UIStackView()
    private let hStack = UIStackView()
    
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        setupUI(title: title, subtitle: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        textStack.axis = .horizontal
        textStack.spacing = subtitle.isEmpty ? 0 : 4
        textStack.alignment = .center
        textStack.distribution = .fill
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        textStack.addArrangedSubview(titleLabel)
        if !subtitle.isEmpty {
            textStack.addArrangedSubview(subtitleLabel)
        }
        
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        hStack.addArrangedSubview(iconImageView)
        hStack.addArrangedSubview(textStack)
        
        addSubview(hStack)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 19),
            iconImageView.heightAnchor.constraint(equalToConstant: 19),
            
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
