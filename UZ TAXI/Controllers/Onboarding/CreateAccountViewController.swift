//
//  CreateAccountViewController.swift
//  UzTaxi
//
//  Created by Asliddin Rasulov on 26/01/20.
//

import UIKit

class CreateAccountViewController: UIViewController {

    private let photoView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = .boldSystemFont(ofSize: 49)
        label.textColor = color
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea."
        label.font = .systemFont(ofSize: 12)
        label.textColor = color
        label.sizeToFit()
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.returnKeyType = .done
        textField.leftViewMode = .always
        textField.leftView = UIView (
            frame: CGRect (
                x: 0, y: 0, width: 10, height: 0
            )
        )
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .systemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Surname"
        textField.returnKeyType = .done
        textField.leftViewMode = .always
        textField.leftView = UIView (
            frame: CGRect (
                x: 0, y: 0, width: 10, height: 0
            )
        )
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .systemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = color
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(
            self, action: #selector(didTapCreateAccountButton), for: .touchUpInside
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
        view.addSubview(nameTextField)
        nameTextField.delegate = self
        view.addSubview(surnameTextField)
        surnameTextField.delegate = self
        view.addSubview(createAccountButton)
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
        nameTextField.frame = CGRect(
            x: view.width * 0.1, y: infoLabel.bottom + 20,
            width: view.width * 0.8, height: view.height * 0.06
        )
        surnameTextField.frame = CGRect(
            x: view.width * 0.1, y: nameTextField.bottom + 20,
            width: view.width * 0.8, height: view.height * 0.06
        )
        createAccountButton.frame = CGRect(
            x: view.width * 0.1, y: surnameTextField.bottom + 40,
            width: view.width * 0.8, height: view.height * 0.06
        )
        lineView.frame = CGRect(
            x: view.width * 0.1, y: createAccountButton.bottom + 60,
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
    
    @objc private func didTapCreateAccountButton() {
        
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty else {
            return
        }
        
        UserDefaults.standard.setValue(true, forKey: "logged")
        
        view.window?.rootViewController?.dismiss(
            animated: false, completion: nil
        )
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            surnameTextField.becomeFirstResponder()
        } else {
            surnameTextField.resignFirstResponder()
        }
        return true
    }
}
