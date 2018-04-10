//
//  LaunchScreenView.swift
//  LocallySourced
//
//  Created by Clint Mejia on 3/4/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    /**
     Simply zooming in of a view: set view scale to 0 and zoom to Identity on 'duration' time interval.
     
     - parameter duration: animation duration
     */
    func zoomIn(duration: TimeInterval = 2.0) {
        self.transform = CGAffineTransform(scaleX: 8.0, y: 8.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    /**
     Simply zooming out of a view: set view scale to Identity and zoom out to 0 on 'duration' time interval.
     
     - parameter duration: animation duration
     */
    func zoomOut(duration: TimeInterval = 0.2) {
        self.transform = CGAffineTransform.identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    /**
     Zoom in any view with specified offset magnification.
     
     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomInWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform.identity
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
    
    /**
     Zoom out any view with specified offset magnification.
     
     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomOutWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
}



protocol SplashScreenDelegate {
    func animationEnded()
}

class SplashScreen: UIView, UICollisionBehaviorDelegate {
    
    var delegate: SplashScreenDelegate?
    
    //MARK: - Outlets
    lazy var imageViewOne: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logoCentered").withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewTwo: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "logoCentered").withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.white
        imageView.clipsToBounds = true
        return imageView
    }()
//
//    lazy var imageViewThree: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image =  #imageLiteral(resourceName: "asparagus").withRenderingMode(.alwaysTemplate)
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//
//    lazy var nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Access Green"
//        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        label.textColor = .black
//        return label
//    }()
//
//    lazy var logoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "logo")
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        return imageView
//    }()
    
    // MARK: - Inititalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Functions
    private func commonInit() {
        //        backgroundColor = UIColor(displayP3Red: 100/255, green: 180/255, blue: 130/255, alpha: 1)
        backgroundColor = UIColor.black
        setupViews()
        animateView()
    }
    
    
    private func setupViews() {
        setupImageViewOne()
        setupImageViewTWo()
//        setupImageViewThree()
        //        setupNameLabel()
//        setupLogoImageView()
    }
    
    func animateTranslation(with valueOne: CGFloat, with valueTwo: CGFloat, with valueThree: CGFloat, for image: UIImageView) {
        let toValue = CATransform3DMakeTranslation(valueOne, valueTwo, valueThree)
        let animation = CABasicAnimation(keyPath: "transform")
        animation.toValue = toValue
        animation.duration = 9
        let image = image
        image.layer.add(animation, forKey: nil)
    }
    
    private func animations() {
        animateTranslation(with: 200, with: 400, with: -100, for: self.imageViewOne)
//        animateTranslation(with: -800, with: -100, with: -100, for: self.imageViewTwo)
//        animateTranslation(with: -200, with: -400, with: -100, for: self.imageViewThree)
    }
    
    private func animateView() {
        imageViewOne. CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
        
        
//        imageViewOne.zoomIn()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
//            self.imageViewTwo.isHidden = false
//            self.imageViewTwo.zoomIn()
//        }
    }
    
    
    private func fadeView() {
        self.imageViewOne.layer.opacity = 0
//        self.imageViewTwo.layer.opacity = 0
//        self.imageViewThree.layer.opacity = 0
//        self.nameLabel.layer.opacity = 0
    }
    
//    private func animateView() {
//        UIView.animate(withDuration: 4.0, animations: {
//            self.animations()
//        }) { (success:Bool) in
//            if success {
//                //Fade the entire view out
//                UIView.animate(withDuration: 4.0, animations: {
//                    self.fadeView()
//                }) {(success) in
//                    self.delegate?.animationEnded()
//                }
//            }
//        }
//    }
    
    // MARK: - SNP Constraints
    // apple image
    private func setupImageViewOne() {
        addSubview(imageViewOne)
        imageViewOne.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(-150)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(snp.height).multipliedBy(0.15)
            make.width.equalTo(snp.height)
        }
    }
    
    // artichoke image
    private func setupImageViewTWo() {
        addSubview(imageViewTwo)
        imageViewTwo.isHidden = true
        imageViewTwo.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(-150)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(snp.height).multipliedBy(0.15)
            make.width.equalTo(snp.height)
        }
    }
//
//    // asparagus image
//    private func setupImageViewThree() {
//        addSubview(imageViewThree)
//        imageViewThree.snp.makeConstraints { (make) -> Void in
//            make.centerY.equalTo(snp.centerY).offset(-100)
//            make.centerX.equalTo(snp.centerX).offset(-175)
//            make.height.equalTo(snp.height).multipliedBy(0.08)
//            make.width.equalTo(snp.height)
//        }
//    }
//    
//    
//    private func setupNameLabel() {
//        nameLabel.snp.makeConstraints { (make) in
//            make.centerX.equalTo(snp.centerX)
//            make.centerY.equalTo(snp.centerY).offset(-150)
//        }
//    }
//    
//    private func setupLogoImageView() {
//        logoImageView.snp.makeConstraints { (make) in
//            make.width.equalTo(self.snp.height).multipliedBy(0.25)
//            make.height.equalTo(self).multipliedBy(0.25)
//            make.centerX.equalTo(self)
//            make.centerY.equalTo(self).offset(-150)
//        }
//    }
    
}

