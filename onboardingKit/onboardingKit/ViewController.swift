//
//  ViewController.swift
//  onboardingKit
//
//  Created by Ai on 1/6/20.
//  Copyright © 2020 Ai. All rights reserved.
//

import UIKit

import OnboardingKItFramework

class ViewController: UIViewController{

    var onboarding = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboarding = OnboardingView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        onboarding.addBackgroundImage(imageName: "background_img.jpg")
        self.view.addSubview(onboarding)
    }


}

