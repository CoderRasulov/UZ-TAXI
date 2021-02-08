//
//  LaunchCollectionViewCell.swift
//  UzTaxi
//
//  Created by Asliddin Rasulov on 25/01/20.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "LaunchCollectionViewCell"
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = color
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = color
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = CGRect(
            x: contentView.width * 0.15, y: contentView.width * 0.2,
            width: contentView.width * 0.7, height: contentView.width * 0.7
        )
        titleLabel.frame = CGRect(
            x: contentView.width * 0.1, y: photoImageView.bottom + contentView.width * 0.1,
            width: contentView.width * 0.8, height: contentView.height * 0.05
        )
        infoLabel.frame = CGRect(
            x: contentView.width * 0.1, y: titleLabel.bottom + contentView.width * 0.05,
            width: contentView.width * 0.8, height: contentView.height * 0.1
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        titleLabel.text = nil
        infoLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(data: [String]) {
        photoImageView.image = UIImage(named: data[0])
        titleLabel.text = data[1]
        infoLabel.text = data[2]
        
        infoLabel.sizeToFit()
    }
}
