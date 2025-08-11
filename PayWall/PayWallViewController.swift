import UIKit


extension PayWallViewController {
    enum Constants {
        
    }
}

final class PayWallViewController: UIViewController {
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.bg.cgColor,
            UIColor.filing.cgColor,
        ]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 2)
        return layer
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 19, weight: .bold)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let tupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tup")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    private func configure() {
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupViews() {
        view.addSubview(closeButton)
        view.addSubview(tupImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tupImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 14),
            tupImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tupImageView.widthAnchor.constraint(equalToConstant: 88),
            tupImageView.heightAnchor.constraint(equalToConstant: 118),

        ])
    }
}

