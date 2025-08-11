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
    
    private let fullControlLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let text = "Unlock Full Control\n with AutoClicker Pro"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 34
        paragraphStyle.maximumLineHeight = 34
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .foregroundColor: UIColor.white,
            .kern: 0.38,
            .paragraphStyle: paragraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        
        return label
    }()
    
    private var tapLessLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap less."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var winMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Win more."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var automateAnythingLabel: UILabel = {
        let label = UILabel()
        label.text = "Automate anything."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messagesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 14
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        view.addSubview(fullControlLabel)
        view.addSubview(messagesStackView)
        messagesStackView.addArrangedSubview(tapLessLabel)
        messagesStackView.addArrangedSubview(winMoreLabel)
        messagesStackView.addArrangedSubview(automateAnythingLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tupImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 14),
            tupImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tupImageView.widthAnchor.constraint(equalToConstant: 88),
            tupImageView.heightAnchor.constraint(equalToConstant: 118),
            
            fullControlLabel.topAnchor.constraint(equalTo: tupImageView.bottomAnchor, constant: 48),
            fullControlLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullControlLabel.widthAnchor.constraint(equalToConstant: 294),
            fullControlLabel.heightAnchor.constraint(equalToConstant: 68),
            
            messagesStackView.topAnchor.constraint(equalTo: fullControlLabel.bottomAnchor, constant: 8),
            messagesStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messagesStackView.widthAnchor.constraint(equalToConstant: 294),
            messagesStackView.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
}

