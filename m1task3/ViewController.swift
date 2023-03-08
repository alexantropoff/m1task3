//
//  ViewController.swift
//  m1task3
//
//  Created by Alex Antropoff on 07.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let squareView = UIView()
    let slider = UISlider()
    var animator: UIViewPropertyAnimator!
    var squareWidth: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(squareView)
        view.addSubview(slider)
        
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        animator.pausesOnCompletion = true
        slider.addTarget(self, action: #selector(releaseSlider), for: .touchUpInside)
        slider.addTarget(self, action: #selector(releaseSlider), for: .touchDragOutside)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
        
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if(slider.isTracking){return}
        slider.value=slider.minimumValue
        squareWidth = view.frame.width/6
        squareView.frame = CGRect(x: view.layoutMargins.left, y: view.layoutMargins.top + squareWidth, width: squareWidth, height: squareWidth)
        squareView.layer.cornerRadius = 8
        squareView.backgroundColor = .blue
        
        slider.frame = CGRect(x: view.layoutMargins.left, y: view.layoutMargins.top + squareWidth*2 + 30, width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right, height: 20)
        animator.stopAnimation(true)
        squareView.transform = .identity
        animator.addAnimations {
            self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2).scaledBy(x: 1.5, y: 1.5)
            self.squareView.frame.origin.x = self.view.frame.width-self.squareView.frame.width-self.view.layoutMargins.right
        }
    }
    @objc func sliderValueChanged() {
        animator.fractionComplete = CGFloat( slider.value )
    }
    @objc func releaseSlider(){
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: .common)
        animator.startAnimation()
    }
    @objc func update() {
        if(animator.isRunning){
            slider.value=Float(animator.fractionComplete)
        }
    }
}
