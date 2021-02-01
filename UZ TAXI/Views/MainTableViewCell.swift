//
//  MainCell.swift
//  UzTaxi
//
//  Created by Asliddin Rasulov on 28/11/20.
//

import UIKit


class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifire = "MainCell"
    
    private let findPlacesView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.01176470588, blue: 0.3058823529, alpha: 0.05922299821)
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "lupa")
        view.addSubview(imageView)
        imageView.centerY(inView: view, leftAnchor: view.leftAnchor, paddingLeft: 20)
        imageView.setDemissions(
            height: UIScreen.main.bounds.height / 40, width: UIScreen.main.bounds.height / 40
        )
        
        let label = UILabel()
        label.textColor = color
        label.text = "Where will you go?"
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        label.centerY(inView: view)
        label.anchor(
            left: imageView.rightAnchor, paddingLeft: 20
        )
        return view
    }()
    
    private let deliveryView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.01176470588, blue: 0.3058823529, alpha: 0.05922299821)
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "delivery")
        view.addSubview(imageView)
        imageView.anchor(
            top: view.topAnchor, left: view.leftAnchor,
            bottom: view.bottomAnchor, right: view.rightAnchor
        )
        
        let label = UILabel()
        label.textColor = color
        label.text = "Delivery"
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        label.centerY(inView: view)
        label.anchor(
            left: view.leftAnchor, paddingLeft: 20
        )
        
        return view
    }()
    
    private let addAdressView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.01176470588, blue: 0.3058823529, alpha: 0.05922299821)
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "adress")
        view.addSubview(imageView)
        imageView.anchor(
            top: view.topAnchor, left: view.leftAnchor,
            bottom: view.bottomAnchor, right: view.rightAnchor
        )
        
        let label = UILabel()
        label.textColor = color
        label.text = "Add address"
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        label.centerY(inView: view)
        label.anchor(
            left: view.leftAnchor, paddingLeft: 20
        )
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
    // MARK: - Helper Functions
    
    private func addSubviews() {
        
        selectionStyle = .none
        
        contentView.addSubview(findPlacesView)
        findPlacesView.anchor(
            top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor,
            paddingTop: 0, paddingLeft: 10, paddingRight: 10, height: UIScreen.main.bounds.height / 15
        )
        
        contentView.addSubview(deliveryView)
        deliveryView.anchor(
            top: findPlacesView.bottomAnchor, left: findPlacesView.leftAnchor, paddingTop: 10,
            width: UIScreen.main.bounds.width / 2.4, height: UIScreen.main.bounds.height / 13
        )
        
        contentView.addSubview(addAdressView)
        addAdressView.anchor(
            top: findPlacesView.bottomAnchor, right: findPlacesView.rightAnchor, paddingTop: 10,
            width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 13
        )
        
        contentView.bottomAnchor.constraint(
            equalTo: addAdressView.bottomAnchor, constant: 5
        ).isActive = true
    }
}
