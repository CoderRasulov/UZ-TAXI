//
//  VerifyViewController.swift
//  UzTaxi
//
//  Created by Asliddin Rasulov on 26/01/20.
//

import UIKit
import PinEntryField

class VerifyViewController: UIViewController {

    private let photoView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Verify"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = color
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "We texted you a code to verify your phone number"
        label.font = .systemFont(ofSize: 12)
        label.textColor = color
        label.sizeToFit()
        return label
    }()
    
    private let passwordView: CodeView = {
        let view = CodeView(numberOfPin: 4, inputColor: .white, font: .systemFont(ofSize: 22), codeStyle: .rounded, boxSize: CGSize(width: 80, height: 80), textColor: .white, spacing: 10, activeFieldColor: color, backgroundClr: color)
        view.backgroundColor = .clear
        
        view.becomeFirstResponder()
        return view
    }()
    
    private let changePhoneNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Didn`t receive code?", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(
            self, action: #selector(didTapChangePhoneNumberButton),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private let resendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Resend", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(
            self, action: #selector(didTapResendButton),
            for: .touchUpInside
        )
        
        return button
    }()
    
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBackground
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(
            self, action: #selector(didTapNextButton), for: .touchUpInside
        )
        
        return button
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(photoView)
        view.addSubview(welcomeLabel)
        view.addSubview(infoLabel)
        view.addSubview(passwordView)
        passwordView.delegate = self
        view.addSubview(changePhoneNumberButton)
        view.addSubview(resendButton)
        view.addSubview(nextButton)
        view.addSubview(lineView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        photoView.frame = CGRect(
            x: 0, y: 0, width: view.width, height: view.height * 0.35
        )
        
        configureLogo()
        
        welcomeLabel.frame = CGRect(
            x: view.width * 0.1, y: photoView.bottom + 20,
            width: 300, height: 40
        )
        infoLabel.frame = CGRect(
            x: welcomeLabel.left, y: welcomeLabel.bottom + 10,
            width: view.width * 0.8, height: heightForView(text: infoLabel.text!, font: infoLabel.font, width: view.width * 0.8)
        )
        passwordView.frame = CGRect(
            x: view.width * 0.1, y: infoLabel.bottom + 20,
            width: view.width * 0.8, height: 80
        )
        changePhoneNumberButton.frame = CGRect(
            x: view.width * 0.1, y: passwordView.bottom + 20,
            width: changePhoneNumberButton.intrinsicContentSize.width,
            height: changePhoneNumberButton.intrinsicContentSize.height
        )
        resendButton.frame = CGRect(
            x: view.width * 0.9 - resendButton.intrinsicContentSize.width,
            y: passwordView.bottom + 20,
            width: resendButton.intrinsicContentSize.width,
            height: resendButton.intrinsicContentSize.height
        )
        nextButton.frame = CGRect(
            x: view.width * 0.1, y: changePhoneNumberButton.bottom + 20,
            width: view.width * 0.8, height: view.height * 0.06
        )
        lineView.frame = CGRect(
            x: view.width * 0.1, y: nextButton.bottom + 60,
            width: view.width * 0.78, height: 2
        )
    }
    
    private func configureLogo() {
        let imageView = UIImageView()
        imageView.frame = CGRect(
            x: photoView.width / 4, y: photoView.height / 4,
            width: photoView.width / 2, height: photoView.height / 2
        )
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "logo")
        photoView.addSubview(imageView)
    }
    
    @objc private func didTapNextButton() {
        let createAccountVC = CreateAccountViewController()
        createAccountVC.modalTransitionStyle = .crossDissolve
        createAccountVC.modalPresentationStyle = .fullScreen
        present(createAccountVC, animated: true, completion: nil)
    }
    
    @objc private func didTapChangePhoneNumberButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapResendButton() {
        // resend sms
    }
}

extension VerifyViewController: PinInputDelegate {
    func didFinishInput(_ inputView: CodeView, didFinishWith text: String) {
        if text != "1234" {
            for _ in 0...3 {
                passwordView.deleteBackward()
            }
        } else {
            nextButton.backgroundColor = color
            passwordView.resignFirstResponder()
        }
    }
}
