//
//  LogInViewController.swift
//  UzTaxi
//
//  Created by Asliddin Rasulov on 26/01/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController {

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
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = color
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(
            self, action: #selector(didTapLoginButton), for: .touchUpInside
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
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.delegate = self
        view.addSubview(loginButton)
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
        phoneNumberTextField.frame = CGRect(
            x: view.width * 0.1, y: infoLabel.bottom + 40,
            width: view.width * 0.8, height: view.height * 0.06
        )
        loginButton.frame = CGRect(
            x: view.width * 0.1, y: phoneNumberTextField.bottom + 40,
            width: view.width * 0.8, height: view.height * 0.06
        )
        lineView.frame = CGRect(
            x: view.width * 0.1, y: loginButton.bottom + 60,
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
    
    @objc private func didTapLoginButton() {
        
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            return
        }
        
        let params: Parameters = [
            "phone": phoneNumber
        ]
        
        AF.request("https://botmaker.uz/api/client/mobile/1.0/registration/submit", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let verifyVC = VerifyViewController()
                verifyVC.modalPresentationStyle = .fullScreen
                verifyVC.modalTransitionStyle = .crossDissolve
                self.present(verifyVC, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberTextField.resignFirstResponder()
        return true
    }
}
