import UIKit

extension PayWallViewController {
    enum Constants {
        
    }
}

final class PayWallViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.bg.cgColor,
            UIColor.filing.cgColor,
        ]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
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
        
        let text = "Unlock Full Control\nwith AutoClicker Pro"
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
    
    private let featureStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let features: [(String, String)] = [
            ("No limits", "Tap as much as you want"),
            ("Place multiple tap points on any screen", " "),
            ("Save setups and load them instantly", " "),
            ("Fast & accurate", "Works even on tricky buttons"),
            ("Use it anywhere", "Games, apps, or web tools")
        ]
        
        for (title, subtitle) in features {
            let featureView = FeatureItemView(title: title, subtitle: subtitle)
            stack.addArrangedSubview(featureView)
        }
        return stack
    }()
    
    private let priceSwitchContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 35
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let trialLabel: UILabel = {
        let trialLabel = UILabel()
        trialLabel.text = "Start with 3-Day Free Trial"
        trialLabel.font = .systemFont(ofSize: 11)
        trialLabel.isHidden = true
        trialLabel.textColor = .main
        return trialLabel
    }()
    
    private lazy var priceInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let priceLabel = UILabel()
        priceLabel.text = "$5.99/week"
        priceLabel.font = .boldSystemFont(ofSize: 17)
        priceLabel.textColor = .white
        
        let cancelLabel = UILabel()
        cancelLabel.text = "Cancel anytime"
        cancelLabel.font = .systemFont(ofSize: 11)
        cancelLabel.textColor = .lightGray
        
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(trialLabel)
        stack.addArrangedSubview(cancelLabel)
        
        return stack
    }()
    
    private let priceSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .main
        sw.thumbTintColor = .white
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = .main
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 35
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "Privacy"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subscriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Subscription Policy"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomButtonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [termsLabel, privacyLabel, subscriptionLabel])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
        setupConstraints()
        
        priceSwitch.addTarget(self, action: #selector(priceSwitchChanged), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    private func configure() {
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(closeButton)
        contentView.addSubview(tupImageView)
        contentView.addSubview(fullControlLabel)
        contentView.addSubview(messagesStackView)
        contentView.addSubview(featureStack)
        contentView.addSubview(priceSwitchContainer)
        contentView.addSubview(continueButton)
        contentView.addSubview(bottomButtonsStackView)
        
        messagesStackView.addArrangedSubview(tapLessLabel)
        messagesStackView.addArrangedSubview(winMoreLabel)
        messagesStackView.addArrangedSubview(automateAnythingLabel)
        
        priceSwitchContainer.addSubview(priceInfoStack)
        priceSwitchContainer.addSubview(priceSwitch)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),
            
            
            closeButton.topAnchor.constraint(equalTo: contentView   .topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tupImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 14),
            tupImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
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
            
            featureStack.topAnchor.constraint(equalTo: messagesStackView.bottomAnchor, constant: 36),
            featureStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            priceSwitchContainer.topAnchor.constraint(equalTo: featureStack.bottomAnchor, constant: 76),
            priceSwitchContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceSwitchContainer.widthAnchor.constraint(equalToConstant: 343),
            priceSwitchContainer.heightAnchor.constraint(equalToConstant: 72),
            
            priceInfoStack.leadingAnchor.constraint(equalTo: priceSwitchContainer.leadingAnchor, constant: 16),
            priceInfoStack.centerYAnchor.constraint(equalTo: priceSwitchContainer.centerYAnchor),
            
            priceSwitch.centerYAnchor.constraint(equalTo: priceSwitchContainer.centerYAnchor),
            priceSwitch.trailingAnchor.constraint(equalTo: priceSwitchContainer.trailingAnchor, constant: -16),
            
            continueButton.topAnchor.constraint(equalTo: priceSwitchContainer.bottomAnchor, constant: 25),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 343),
            continueButton.heightAnchor.constraint(equalToConstant: 72),
            
            bottomButtonsStackView.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 24),
                bottomButtonsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                bottomButtonsStackView.widthAnchor.constraint(equalToConstant: 260),
                bottomButtonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    @objc private func priceSwitchChanged(_ sender: UISwitch) {
        sender.thumbTintColor = sender.isOn ? .black : .white
        continueButton.setTitle(sender.isOn ? "Start Free Trial" : "Continue", for: .normal)
        trialLabel.isHidden = !sender.isOn
    }
}
