//
//  HistoryCell.swift
//  Uber
//
//  Created by Asliddin Rasulov on 15/12/20.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifire = "HistoryCell"
    
  
    
    
    // MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        
        selectionStyle = .none
        
//        contentView.addSubview(constAbout)
//        constAbout.anchor(
//            top: contentView.topAnchor, left: contentView.leftAnchor,
//            paddingTop: 16, paddingLeft: 16
//        )
//        
//        contentView.addSubview(aboutText)
//        aboutText.anchor(
//            top: constAbout.bottomAnchor, left: constAbout.leftAnchor, right: contentView.rightAnchor,
//            paddingTop: 10, paddingRight: 16
//        )
//        
//        contentView.bottomAnchor.constraint(
//            equalTo: aboutText.bottomAnchor, constant: 16
//        ).isActive = true
    }
}

