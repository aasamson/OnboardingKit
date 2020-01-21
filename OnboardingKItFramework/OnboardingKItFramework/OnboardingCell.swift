//
//  OnboardingCell.swift
//  OnboardingKItFramework
//
//  Created by Ai on 1/14/20.
//  Copyright © 2020 Ai. All rights reserved.
//

import UIKit

import Foundation

class OnboardingCell: UICollectionViewCell {
    
     let image: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let subHeaderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 260))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(image)
        addSubview(headerLabel)
        addSubview(subHeaderLabel)
        
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
    
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -250),
            headerLabel.topAnchor.constraint(equalTo: image.bottomAnchor),
            headerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            headerLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -200),
            subHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            subHeaderLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            subHeaderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            subHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
        
    }
    
    public func setSubHeaderLabel(font: String, size: Int, color: UIColor) {
        subHeaderLabel.font = UIFont(name: font, size: CGFloat(size))
        subHeaderLabel.textColor = color
    }
    
    public func setHeaderLabel(font: String, size: Int, color: UIColor) {
        headerLabel.font = UIFont(name: font, size: CGFloat(size))
        headerLabel.textColor = color
    }
    
}
