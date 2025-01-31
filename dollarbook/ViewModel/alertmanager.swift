//
//  alertmanager.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 28/01/25.
//

import Foundation
import UIKit
class alertmanager:UIView
{
    // MARK: - Properties
    private let bgLabel = UILabel()
        private let titleLabel = UILabel()
        private let messageLabel = UILabel()
        private let okButton = UIButton()

        // MARK: - Initializer
        init(title: String, message: String) {
            super.init(frame: .zero)
            setupUI()
            bgLabel.text = ""
            titleLabel.text = ""
            messageLabel.text = message
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - UI Setup
        private func setupUI() {
            self.backgroundColor = UIColor.white
            self.layer.cornerRadius = 15
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.2
            self.layer.shadowRadius = 10
            self.layer.shadowOffset = CGSize(width: 0, height: 5)

            bgLabel.backgroundColor = ColorManager.expenseColor().withAlphaComponent(0.2)
            
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            
            // Title Label
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            

            // Message Label
            messageLabel.font = UIFont.systemFont(ofSize: 14)
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            messageLabel.textColor = .darkGray

            // OK Button
            okButton.setTitle("OK", for: .normal)
            okButton.backgroundColor = ColorManager.expenseColor()
            okButton.setTitleColor(.white, for: .normal)
            okButton.layer.cornerRadius = 8
            okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)

            // Add Subviews
            self.addSubview(bgLabel)
            //self.addSubview(titleLabel)
            self.addSubview(messageLabel)
            self.addSubview(okButton)

            // Layout Constraints
            self.translatesAutoresizingMaskIntoConstraints = false
            bgLabel.translatesAutoresizingMaskIntoConstraints = false
            bgLabel.layer.masksToBounds = true
            //titleLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            okButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                bgLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                bgLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                bgLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                bgLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                
//                titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//                titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

                messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

                okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
                okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
                okButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                okButton.widthAnchor.constraint(equalToConstant: 75),
                okButton.heightAnchor.constraint(equalToConstant: 30),
            ])
        }

        // MARK: - Button Action
        @objc private func okButtonTapped() {
            self.removeFromSuperview()
        }
    static func showCustomAlert(title: String, message: String, on viewController: UIViewController) {
        let alertView = alertmanager(title: title, message: message)
        
        viewController.view.addSubview(alertView)
        
        // Center the alert in the view
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 220),
            alertView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
