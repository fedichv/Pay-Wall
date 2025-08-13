//
//  PayWallViewController.swift
//  AutoClickerPro
//

import UIKit

extension PayWallViewController {
    enum Constants {
        enum Layout {
            static let closeButtonTop: CGFloat = 8
            static let closeButtonTrailing: CGFloat = -16
            static let tupImageTop: CGFloat = 14
            static let tupImageWidth: CGFloat = 88
            static let tupImageHeight: CGFloat = 118
            static let fullControlTop: CGFloat = 48
            static let fullControlWidth: CGFloat = 294
            static let fullControlHeight: CGFloat = 68
            static let messagesStackTop: CGFloat = 8
            static let messagesStackWidth: CGFloat = 294
            static let messagesStackHeight: CGFloat = 20
            static let featureStackTop: CGFloat = 36
            static let priceSwitchTop: CGFloat = 76
            static let priceSwitchWidth: CGFloat = 343
            static let priceSwitchHeight: CGFloat = 72
            static let priceInfoLeading: CGFloat = 16
            static let priceSwitchTrailing: CGFloat = -16
            static let continueButtonTop: CGFloat = 25
            static let continueButtonWidth: CGFloat = 343
            static let continueButtonHeight: CGFloat = 72
            static let bottomStackTop: CGFloat = 24
            static let bottomStackWidth: CGFloat = 260
            static let bottomStackBottom: CGFloat = -5
        }

        enum Text {
            static let fullControl = "Unlock Full Control\nwith AutoClicker Pro"
            static let tapLess = "Tap less."
            static let winMore = "Win more."
            static let automateAnything = "Automate anything."
            static let price = "$5.99/week"
            static let cancelAnytime = "Cancel anytime"
            static let trial = "Start with 3-Day Free Trial"
            static let continueButton = "Continue"
            static let startFreeTrial = "Start Free Trial"
            static let terms = "Terms"
            static let privacy = "Privacy"
            static let subscription = "Subscription Policy"
        }

        enum Font {
            static let headline = UIFont.systemFont(ofSize: 28, weight: .bold)
            static let subtitle = UIFont.systemFont(ofSize: 15)
            static let price = UIFont.boldSystemFont(ofSize: 17)
            static let cancel = UIFont.systemFont(ofSize: 11)
            static let trial = UIFont.systemFont(ofSize: 11)
            static let button = UIFont.boldSystemFont(ofSize: 17)
            static let footer = UIFont.systemFont(ofSize: 13)
        }

        enum Color {
            static let title = UIColor.white
            static let subtitle = UIColor.gray
            static let price = UIColor.white
            static let cancel = UIColor.lightGray
            static let trial = UIColor.main
            static let background = UIColor.bg
            static let overlay = UIColor.filing
            static let switchOn = UIColor.main
            static let switchThumbOn = UIColor.black
            static let switchThumbOff = UIColor.white
            static let continueText = UIColor.black
        }

        enum Paragraph {
            static let lineHeight: CGFloat = 34
            static var style: NSParagraphStyle {
                let style = NSMutableParagraphStyle()
                style.minimumLineHeight = lineHeight
                style.maximumLineHeight = lineHeight
                style.alignment = .center
                return style
            }
        }

        enum Image {
            static let close = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 19, weight: .bold))
            static let tup = UIImage(named: "tup")
        }
    }
}

final class PayWallViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            Constants.Color.background.cgColor,
            Constants.Color.overlay.cgColor,
        ]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        return layer
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.Image.close, for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let tupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Image.tup
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let fullControlLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        label.attributedText = NSAttributedString(string: Constants.Text.fullControl, attributes: [
            .font: Constants.Font.headline,
            .foregroundColor: Constants.Color.title,
            .kern: 0.38,
            .paragraphStyle: Constants.Paragraph.style
        ])
        return label
    }()

    private var tapLessLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.tapLess
        label.font = Constants.Font.subtitle
        label.textAlignment = .center
        label.textColor = Constants.Color.subtitle
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var winMoreLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.winMore
        label.font = Constants.Font.subtitle
        label.textAlignment = .center
        label.textColor = Constants.Color.subtitle
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var automateAnythingLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.automateAnything
        label.font = Constants.Font.subtitle
        label.textAlignment = .center
        label.textColor = Constants.Color.subtitle
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
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 35
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let trialLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.trial
        label.font = Constants.Font.trial
        label.isHidden = true
        label.textColor = Constants.Color.trial
        return label
    }()

    private lazy var priceInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false

        let priceLabel = UILabel()
        priceLabel.text = Constants.Text.price
        priceLabel.font = Constants.Font.price
        priceLabel.textColor = Constants.Color.price

        let cancelLabel = UILabel()
        cancelLabel.text = Constants.Text.cancelAnytime
        cancelLabel.font = Constants.Font.cancel
        cancelLabel.textColor = Constants.Color.cancel

        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(trialLabel)
        stack.addArrangedSubview(cancelLabel)

        return stack
    }()

    private let priceSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = Constants.Color.switchOn
        sw.thumbTintColor = Constants.Color.switchThumbOff
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Text.continueButton, for: .normal)
        button.titleLabel?.font = Constants.Font.button
        button.backgroundColor = Constants.Color.switchOn
        button.setTitleColor(Constants.Color.continueText, for: .normal)
        button.layer.cornerRadius = 35
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.terms
        label.font = Constants.Font.footer
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = Constants.Color.cancel
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.privacy
        label.font = Constants.Font.footer
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = Constants.Color.cancel
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subscriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.subscription
        label.font = Constants.Font.footer
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = Constants.Color.cancel
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
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),

            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Layout.closeButtonTop),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.Layout.closeButtonTrailing),

            tupImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Constants.Layout.tupImageTop),
            tupImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tupImageView.widthAnchor.constraint(equalToConstant: Constants.Layout.tupImageWidth),
            tupImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.tupImageHeight),

            fullControlLabel.topAnchor.constraint(equalTo: tupImageView.bottomAnchor, constant: Constants.Layout.fullControlTop),
            fullControlLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullControlLabel.widthAnchor.constraint(equalToConstant: Constants.Layout.fullControlWidth),
            fullControlLabel.heightAnchor.constraint(equalToConstant: Constants.Layout.fullControlHeight),

            messagesStackView.topAnchor.constraint(equalTo: fullControlLabel.bottomAnchor, constant: Constants.Layout.messagesStackTop),
            messagesStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messagesStackView.widthAnchor.constraint(equalToConstant: Constants.Layout.messagesStackWidth),
            messagesStackView.heightAnchor.constraint(equalToConstant: Constants.Layout.messagesStackHeight),

            featureStack.topAnchor.constraint(equalTo: messagesStackView.bottomAnchor, constant: Constants.Layout.featureStackTop),
            featureStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            priceSwitchContainer.topAnchor.constraint(equalTo: featureStack.bottomAnchor, constant: Constants.Layout.priceSwitchTop),
            priceSwitchContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceSwitchContainer.widthAnchor.constraint(equalToConstant: Constants.Layout.priceSwitchWidth),
            priceSwitchContainer.heightAnchor.constraint(equalToConstant: Constants.Layout.priceSwitchHeight),

            priceInfoStack.leadingAnchor.constraint(equalTo: priceSwitchContainer.leadingAnchor, constant: Constants.Layout.priceInfoLeading),
            priceInfoStack.centerYAnchor.constraint(equalTo: priceSwitchContainer.centerYAnchor),

            priceSwitch.centerYAnchor.constraint(equalTo: priceSwitchContainer.centerYAnchor),
            priceSwitch.trailingAnchor.constraint(equalTo: priceSwitchContainer.trailingAnchor, constant: Constants.Layout.priceSwitchTrailing),

            continueButton.topAnchor.constraint(equalTo: priceSwitchContainer.bottomAnchor, constant: Constants.Layout.continueButtonTop),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: Constants.Layout.continueButtonWidth),
            continueButton.heightAnchor.constraint(equalToConstant: Constants.Layout.continueButtonHeight),

            bottomButtonsStackView.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: Constants.Layout.bottomStackTop),
            bottomButtonsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomButtonsStackView.widthAnchor.constraint(equalToConstant: Constants.Layout.bottomStackWidth),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.Layout.bottomStackBottom),
        ])
    }

    @objc private func priceSwitchChanged(_ sender: UISwitch) {
        sender.thumbTintColor = sender.isOn ? Constants.Color.switchThumbOn : Constants.Color.switchThumbOff
        continueButton.setTitle(sender.isOn ? Constants.Text.startFreeTrial : Constants.Text.continueButton, for: .normal)
        trialLabel.isHidden = !sender.isOn
    }
}
