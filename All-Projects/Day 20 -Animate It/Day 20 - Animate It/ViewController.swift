//
//  ViewController.swift
//  Day 20 - Animate It
//
//  Created by 杜赛 on 2020/3/17.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var carouselView: UIView!
    
    @IBOutlet weak var rotateView: UIView!
    
    @IBOutlet weak var flipView: UIView!
    var firstView: UIView!
    var secondView: UIView!
    
    @IBOutlet weak var animationButton: UIButton!
    lazy var buttonAnimation = animHandler()
    @IBAction func animationAction(_ sender: UIButton) {
        buttonAnimation()
    }
    
    @IBOutlet weak var curlupButton: UIButton!
    @IBAction func curlupAction(_ sender: UIButton) {
        let options: UIView.AnimationOptions = [.transitionCurlUp]
        curlAnimation(with: curlupButton, by: options)
    }
    
    @IBOutlet weak var curldownButton: UIButton!
    @IBAction func curldownAction(_ sender: UIButton) {
        let options: UIView.AnimationOptions = [.transitionCurlDown]
        curlAnimation(with: curldownButton, by: options)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselAnimationTimer()
        rotateAnimation()
        flipAnimation()
    }
    
    // MARK: - Animation 1
    private func carouselAnimationTimer() {
        let colors = [#colorLiteral(red: 0.4745098039, green: 0.8392156863, blue: 0.9764705882, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
        let width = carouselView.bounds.width
        let height = carouselView.bounds.height
        var currentColor = colors.first!
        carouselView.backgroundColor = currentColor
        let transform = CGAffineTransform(translationX: -carouselView.bounds.width, y: 0)
        
        // ScheduledTimer
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            let layerView = UIView(frame: CGRect(x: width, y: 0, width: width, height: height))
            
            currentColor = colors[colors.index(colors.firstIndex(of: currentColor)!, offsetBy: 1, limitedBy: colors.count - 1) ?? 0]
            layerView.backgroundColor = currentColor
            
            self.carouselView.addSubview(layerView)
            self.carouselAnimation(in: layerView, with: transform)
        }
    }

    // Animate Loop
    private func carouselAnimation(in layerView: UIView, with transform: CGAffineTransform) {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseInOut], animations: {
            layerView.transform = transform
        }, completion: { _ in
            self.carouselView.backgroundColor = layerView.backgroundColor
            for subview in self.carouselView.subviews {
                subview.removeFromSuperview()
            }
        })
    }
    
    // MARK: - Animation 2
    private func rotateAnimation() {
        let path = Polygons(corners: 5, smoothness: 0.5).path(in: CGRect(x: 0, y: 0, width: rotateView.bounds.width, height: rotateView.bounds.height))
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        shape.position = CGPoint(x: rotateView.bounds.midX, y: rotateView.bounds.midY)
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 5.0
        animation.repeatCount = .infinity
        
        shape.add(animation, forKey: "rotation")
        
        rotateView.layer.addSublayer(shape)
    }

    // Reference Link: https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-polygons-and-stars
    struct Polygons {
        let corners: Int
        let smoothness: CGFloat

        func path(in rect: CGRect) -> UIBezierPath {
            guard corners >= 2 else { return UIBezierPath() }
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            var currentAngle = -CGFloat.pi / 2
            let angleAdjustment = .pi * 2 / CGFloat(corners * 2)
            let innerX = center.x * smoothness
            let innerY = center.y * smoothness
            let path = UIBezierPath()
            path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
            var bottomEdge: CGFloat = 0
            for corner in 0..<corners * 2  {
                let sinAngle = sin(currentAngle)
                let cosAngle = cos(currentAngle)
                let bottom: CGFloat
                if corner.isMultiple(of: 2) {
                    bottom = center.y * sinAngle
                    path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
                } else {
                    bottom = innerY * sinAngle
                    path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
                }
                if bottom > bottomEdge {
                    bottomEdge = bottom
                }
                currentAngle += angleAdjustment
            }
            return path
        }
    }
    
    // MARK: - Animation 3
    private func flipAnimation() {
        firstView = UIView(frame: flipView.bounds)
        secondView = UIView(frame: flipView.bounds)

        flipView.backgroundColor = .clear
        firstView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        secondView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)

        secondView.isHidden = true

        flipView.addSubview(firstView)
        flipView.addSubview(secondView)

        perform(#selector(flip), with: nil, afterDelay: 0)
    }

    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .repeat, .autoreverse]

        UIView.transition(with: firstView, duration: 3.0, options: transitionOptions, animations: {})
        UIView.transition(with: secondView, duration: 3.0, options: transitionOptions, animations: {
            self.secondView.isHidden = false
        })
    }
    
    
    // MARK: - Animation 4
    private func animHandler() -> () -> Void {
        let animClosures = [bounce, flash, slide, moveAndRotate]
        var index = 0
        return {
            animClosures[index]()
            index = (index + 1 < animClosures.count) ? index + 1 : 0
        }
    }
    
    lazy private var bounce = { [weak self] in
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 1.0
        pulse.toValue = 0.8
        pulse.autoreverses = true
        pulse.initialVelocity = 0.8
        self?.animationButton.layer.add(pulse, forKey: nil)
    }
    
    lazy private var flash = { [weak self] in
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        self?.animationButton.layer.add(flash, forKey: nil)
    }
    
    lazy private var slide = { [weak self] in
        let originX = self?.animationButton.frame.origin.x
        let originTransfrom = self?.animationButton.transform
        if let x = originX, let transform = originTransfrom {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .autoreverse], animations: {
                self?.animationButton.transform = CGAffineTransform(translationX: x + 100, y: 0)
            }, completion: { _ in
                self?.animationButton.transform = transform
            })
        }
    }
    
    lazy private var moveAndRotate = { [weak self] in
        if let transfrom = self?.animationButton.transform {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: [.curveEaseInOut, .autoreverse],
                animations: {
                    self?.animationButton.transform = CGAffineTransform(translationX: 0, y: 200)
                },
                completion: { _ in
                    self?.animationButton.transform = transfrom
                    UIView.animate(
                        withDuration: 0.5,
                        delay: 0,
                        options: [.curveEaseInOut, .autoreverse],
                        animations: {
                            self?.animationButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        },
                        completion: { _ in
                            self?.animationButton.transform = transfrom
                        }
                    )
                }
            )
        }

    }
    
    // MARK: - Animation 5 && 6
    private func curlAnimation(with button: UIButton, by options: UIView.AnimationOptions) {
        UIView.transition(with: button, duration: 0.8, options: options, animations: {
            button.layer.opacity = 0
        })
    }
    
}






