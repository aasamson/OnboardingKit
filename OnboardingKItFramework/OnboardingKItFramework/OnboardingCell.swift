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
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(image)
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
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
           
        ])
        
    }
    
}
