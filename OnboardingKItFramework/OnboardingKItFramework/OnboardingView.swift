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
    
    var numberOfPages: Int?
    
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
        pageControl.currentPage = 0
        pageControl.numberOfPages = onboardingImages.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControltapped(_:)), for: .touchUpInside)
        return pageControl
    }()
    
    @objc func pageControltapped(_ sender: Any) {
        let page: Int? = pageControl.currentPage
        var frame: CGRect = collection.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        collection.scrollRectToVisible(frame, animated: true)
    }
    
    lazy var nxtButton : UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.darkGray, for: .normal)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return nextButton
    }()
    
    @objc func didTapNext(_ sender: Any) {
        if self.pageControl.currentPage != self.numberOfPages {
            collection.scrollToItem(at: IndexPath(row: pageControl.currentPage + 1, section: 0), at: .right, animated: true)
            nxtButton.setTitle("Next", for: .normal)
        } else {
            nxtButton.setTitle("Start", for: .normal)
            nxtButton.setTitleColor(UIColor.orange, for: .normal)
        }
        
    }
    
    lazy var prevButton : UIButton = {
        let prevButton = UIButton()
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.setTitleColor(UIColor.darkGray, for: .normal)
        prevButton.addTarget(self, action: #selector(didTapPrev), for: .touchUpInside)
        return prevButton
    }()

    @objc func didTapPrev(_ sender: Any) {
         
        if pageControl.currentPage == 0 {
            
            prevButton.setTitle("", for: .normal)
            
        } else {
            
            collection.scrollToItem(at: IndexPath(row: pageControl.currentPage - 1, section: 0), at: .left, animated: true)
            prevButton.setTitle("Prev", for: .normal)
            print("here")
        }
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        collection.delegate = self
        collection.dataSource = self
        
        self.addSubview(collection)
        self.addSubview(pageControl)
        self.addSubview(nxtButton)
        self.addSubview(prevButton)
    
        pageControl.numberOfPages = onboardingImages.count
        self.numberOfPages = pageControl.numberOfPages - 1
        

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
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nxtButton.topAnchor.constraint(equalTo: collection.bottomAnchor),
            nxtButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            nxtButton.leftAnchor.constraint(equalTo: pageControl.rightAnchor, constant: -100),
            nxtButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            prevButton.topAnchor.constraint(equalTo: collection.bottomAnchor),
            prevButton.rightAnchor.constraint(equalTo: pageControl.leftAnchor,constant: 100),
            prevButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            prevButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
        
    }
    
}

extension OnboardingView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return onboardingImages.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return collection.bounds.size
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCell
    
        cell.image.image = UIImage(named: onboardingImages[indexPath.row])
        cell.headerLabel.text = "Test"
        cell.subHeaderLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        
        cell.setHeaderLabel(font: "Helvetica-Bold", size: 30, color: UIColor.black)
        cell.setSubHeaderLabel(font: "Helvetica", size: 18, color: UIColor.gray)
        
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        pageControl.currentPage = Int(roundedIndex)
        if pageControl.currentPage == self.numberOfPages {
            nxtButton.setTitle("Start", for: .normal)
            nxtButton.setTitleColor(UIColor.orange, for: .normal)
            prevButton.setTitle("Prev", for: .normal)
            prevButton.setTitleColor(UIColor.darkGray, for: .normal)
        } else if pageControl.currentPage == 0 {
            nxtButton.setTitle("Next", for: .normal)
            nxtButton.setTitleColor(UIColor.darkGray, for: .normal)
            prevButton.setTitle("", for: .normal)
            prevButton.setTitleColor(UIColor.darkGray, for: .normal)
        } else {
            nxtButton.setTitle("Next", for: .normal)
            nxtButton.setTitleColor(UIColor.darkGray, for: .normal)
            prevButton.setTitle("Prev", for: .normal)
            prevButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
    }
    
    /*public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let visibleRect = CGRect(origin: collection.contentOffset, size: collection.bounds.size)
       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
       if let visibleIndexPath = collection.indexPathForItem(at: visiblePoint) {
                pageControl.currentPage = visibleIndexPath.row
       }
    }*/
    
}
