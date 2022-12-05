//
//  ViewController.swift
//  Natenadze animations
//
//  Created by Davit Natenadze on 04.12.22.
//

import UIKit

class ViewController: UIViewController {
    
    var isDragging = false
    var redBoxLocationX = 0.0
    var redBoxLocationY = 0.0
    
    let topRightView = UIView()
    let topLeftView = UIView()
    let bottomLeftView = UIView()
    let bottomRightView = UIView()
    let rollLabel:UILabel = {
        let label = UILabel()
        label.text = "Roll"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let resizeLabel:UILabel = {
        let label = UILabel()
        label.text = "Resize"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let shakeLabel:UILabel = {
        let label = UILabel()
        label.text = "Shake"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let blinkLabel:UILabel = {
        let label = UILabel()
        label.text = "Blink"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let redBox: UIView = {
        let boxView = UIView()
        boxView.backgroundColor = .red
        boxView.translatesAutoresizingMaskIntoConstraints = false
        return boxView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopRightView()
        setTopLeftView()
        setBottomLeftView()
        setBottomRightView()
        setBoxConstraints()
        redBox.isUserInteractionEnabled = true
        setLabelConstraints()
    }
    
    func setTopLeftView() {
        view.addSubview(topLeftView)
        topLeftView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLeftView.topAnchor.constraint(equalTo: view.topAnchor),
            topLeftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLeftView.heightAnchor.constraint(equalToConstant: (view.frame.height / 2) - 1),
            topLeftView.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - 1)
        ])
        topLeftView.backgroundColor = .tintColor
    }
    func setTopRightView() {
        view.addSubview(topRightView)
        topRightView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topRightView.topAnchor.constraint(equalTo: view.topAnchor),
            topRightView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topRightView.heightAnchor.constraint(equalToConstant: (view.frame.height / 2) - 1),
            topRightView.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - 1)
        ])
        topRightView.backgroundColor = .tintColor
    }
    func setBottomLeftView() {
        view.addSubview(bottomLeftView)
        bottomLeftView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLeftView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomLeftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomLeftView.heightAnchor.constraint(equalToConstant: (view.frame.height / 2) - 1),
            bottomLeftView.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - 1)
        ])
        bottomLeftView.backgroundColor = .tintColor
    }
    func setBottomRightView() {
        view.addSubview(bottomRightView)
        bottomRightView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomRightView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomRightView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomRightView.heightAnchor.constraint(equalToConstant: (view.frame.height / 2) - 1),
            bottomRightView.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - 1)
        ])
        bottomRightView.backgroundColor = .tintColor
    }
    func setLabelConstraints() {
        topLeftView.addSubview(rollLabel)
        topRightView.addSubview(resizeLabel)
        bottomLeftView.addSubview(blinkLabel)
        bottomRightView.addSubview(shakeLabel)
        NSLayoutConstraint.activate([
            rollLabel.centerXAnchor.constraint(equalTo: topLeftView.centerXAnchor),
            rollLabel.centerYAnchor.constraint(equalTo: topLeftView.centerYAnchor),
            rollLabel.heightAnchor.constraint(equalToConstant: 50),
            rollLabel.widthAnchor.constraint(equalToConstant: 100),
            resizeLabel.centerXAnchor.constraint(equalTo: topRightView.centerXAnchor),
            resizeLabel.centerYAnchor.constraint(equalTo: topRightView.centerYAnchor),
            resizeLabel.heightAnchor.constraint(equalToConstant: 50),
            resizeLabel.widthAnchor.constraint(equalToConstant: 100),
            blinkLabel.centerXAnchor.constraint(equalTo: bottomLeftView.centerXAnchor),
            blinkLabel.centerYAnchor.constraint(equalTo: bottomLeftView.centerYAnchor),
            blinkLabel.heightAnchor.constraint(equalToConstant: 50),
            blinkLabel.widthAnchor.constraint(equalToConstant: 100),
            shakeLabel.centerXAnchor.constraint(equalTo: bottomRightView.centerXAnchor),
            shakeLabel.centerYAnchor.constraint(equalTo: bottomRightView.centerYAnchor),
            shakeLabel.heightAnchor.constraint(equalToConstant: 50),
            shakeLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    func setBoxConstraints() {
        view.addSubview(redBox)
        NSLayoutConstraint.activate([
            redBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            redBox.heightAnchor.constraint(equalToConstant: 40),
            redBox.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - redView drag & drop
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: redBox)
        if redBox.bounds.contains(location) {
            isDragging = true
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            guard let touch = touches.first else {return}
            let location = touch.location(in: view)
            redBox.frame.origin.x = location.x - (redBox.frame.width/2)
            redBox.frame.origin.y = location.y - (redBox.frame.height/2)
            
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        redBoxLocationX = redBox.frame.origin.x
        redBoxLocationY = redBox.frame.origin.y
        isDragging = false
        if redBoxLocationX > 195 && redBoxLocationY < 422 {
            self.resize()
        }else if redBoxLocationX > 195 && redBoxLocationY > 422 {
            self.shake()
        }else if redBoxLocationX < 195 && redBoxLocationY < 422 {
            self.rollAnimation()
        }else {
            blink()
        }
        
//        self.animate()
    }
}

// MARK: - Animations
extension ViewController {
    func resize() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.redBox.transform = CGAffineTransform(scaleX: 5, y: 5)
        }
        UIView.animate(withDuration: 2, delay: 0) {
            self.redBox.transform = .identity
        }
    }
    func shake() {
        
            let animation = CAKeyframeAnimation()
            animation.keyPath = "position.x"
            animation.values = [0, 10, -10, 10, 0]
            animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
            animation.duration = 0.4
            animation.isAdditive = true
        redBox.layer.add(animation, forKey: "shake")
        UIView.animate(withDuration: 2, delay: 0) {
            self.redBox.transform = .identity
        }
    }
    func blink() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.redBox.alpha = 0
        }
        UIView.animate(withDuration: 1, delay: 0) {
            self.redBox.alpha = 1
        }
    }
    func rollAnimation() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 2
        animation.duration = 1
        
        redBox.layer.add(animation, forKey: "basic")
        redBox.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
        UIView.animate(withDuration: 2, delay: 0) {
            self.redBox.transform = .identity
        }
    }
}
