//
//  SplashViewController.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 31.07.2022.
//


import UIKit
import Lottie

class SplashViewController: UIViewController {
    let animationView = AnimationView()
    
    var showTabBarController : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.showTabBarController?()
        }
        setupAnimation()
    }
    
    func setupAnimation() {
        animationView.animation          = Animation.named("pikachu")
        animationView.frame.size.width   = (view.frame.size.width)  * 0.84
        animationView.frame.size.height  = (view.frame.size.height) * 0.26
        animationView.center = CGPoint(x: view.frame.size.width  / 2,
                                     y: view.frame.size.height / 2)
        animationView.contentMode        = .scaleAspectFill
        animationView.loopMode           = .repeat(2)
        animationView.play()
        view.addSubview(animationView)
    }}
