//
//  OnboardingView.swift
//  OnboardingKItFramework
//
//  Created by Ai on 1/6/20.
//  Copyright © 2020 Ai. All rights reserved.
//

import Foundation

import UIKit

open class OnboardingView : UIView {
    
    var onboardingImages : [String] =  ["1.jpg","2.jpg","3.jpg"]
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(OnboardingCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .white
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        return collection
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.backgroundColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collection)
        self.addSubview(pageControl)
        
        collection.delegate = self
        collection.dataSource = self
        
        pageControl.numberOfPages = onboardingImages.count
        
        setupAutoLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addBackgroundImage(imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
    }
    
    public func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            collection.rightAnchor.constraint(equalTo: self.rightAnchor),
            collection.leftAnchor.constraint(equalTo: self.leftAnchor),
            collection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150),
            pageControl.topAnchor.constraint(equalTo: collection.bottomAnchor),
            pageControl.rightAnchor.constraint(equalTo: self.rightAnchor),
            pageControl.leftAnchor.constraint(equalTo: self.leftAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}

extension OnboardingView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return onboardingImages.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCell
    
        cell.image.image = UIImage(named: onboardingImages[indexPath.row])
        
        print("cell")
        
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        pageControl.currentPage = Int(roundedIndex)
    }
    
}
