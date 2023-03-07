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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        let squareWidth = view.frame.width/6
        squareView.frame = CGRect(x: view.layoutMargins.left, y: 100, width: squareWidth, height: squareWidth)
        squareView.layer.cornerRadius = 8
        squareView.backgroundColor = .blue
        
        slider.frame = CGRect(x: view.layoutMargins.left, y: 100 + squareWidth*1.5 + 30, width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right, height: 30)
        
        view.addSubview(squareView)
        view.addSubview(slider)
        
        initAnimation()
        slider.addTarget(self, action: #selector(releaseSlider), for: .touchUpInside)
        slider.addTarget(self, action: #selector(releaseSlider), for: .touchDragOutside)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
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
    func initAnimation() {
        let endFrame = CGRect(x: view.frame.width - view.layoutMargins.right - view.layoutMargins.left - squareView.frame.width, y: squareView.frame.origin.y, width: squareView.frame.width, height: squareView.frame.height)
        
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        animator.pausesOnCompletion = true
        animator.addAnimations {
            self.squareView.frame = endFrame
            self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2).scaledBy(x: 1.5, y: 1.5)
        }
    }
    @objc func sliderValueChanged() {
        animator.fractionComplete = CGFloat( slider.value )
    }
}
