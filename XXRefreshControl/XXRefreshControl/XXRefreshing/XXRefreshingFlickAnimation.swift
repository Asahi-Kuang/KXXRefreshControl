//
//  XXRefreshingFlickAnimation.swift
//  XXAnimation
//
//  Created by Kxx.xxQ 一生相伴 on 16/4/15.
//  Copyright © 2016年 Asahi_Kuang. All rights reserved.
//

import UIKit

class XXRefreshingFlickAnimation: UIView {

    private var dotSize        : CGSize
    private var dotDistance    : CGFloat
    lazy var dotsLeftArray     : Array<UIView> = Array.init([])
    lazy var dotsRightArray    : Array<UIView> = Array.init([])
    init(frame: CGRect, _dotSize: CGSize, _dotDistance: CGFloat) {
        //
        dotSize     = _dotSize
        dotDistance = _dotDistance
        super.init(frame: frame)
        buildLoadingView(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func beginRefreshing() {
        for i in 0..<self.dotsLeftArray.count {
            let v: UIView = self.dotsLeftArray[i]
            addAnimationForLeftLayerWithIndex(i, view: v)
        }
        for i in 0..<self.dotsRightArray.count {
            let v: UIView = self.dotsRightArray[i]
            addAnimationForRightViewWithIndex(i, view: v)
        }
    }
    
    func endRefreshing() {
        
        for i in 0..<self.dotsLeftArray.count {
            let v: UIView = self.dotsLeftArray[i]
            v.layer.removeAllAnimations()
        }
        for i in 0..<self.dotsRightArray.count {
            let v: UIView = self.dotsRightArray[i]
            v.layer.removeAllAnimations()
        }
    }
    
    private func buildLoadingView(frame: CGRect) {
        let leftDotColors = [
            UIColor.init(red: 2/255.0,   green: 130/255.0, blue: 85/255.0,  alpha: 1.0),
            UIColor.init(red: 153/255.0, green: 241/255.0, blue: 88/255.0,  alpha: 1.0),
            UIColor.init(red: 221/255.0, green: 55/255.0,  blue: 0.0,       alpha: 1.0),
            UIColor.init(red: 17/255.0,  green: 31/255.0,  blue: 106/255.0, alpha: 1.0)
        ]
        let rightDotColor = [
            UIColor.init(red: 2/255.0,   green: 130/255.0, blue: 85/255.0,  alpha: 1.0),
            UIColor.init(red: 153/255.0, green: 241/255.0, blue: 88/255.0,  alpha: 1.0),
            UIColor.init(red: 221/255.0, green: 55/255.0,  blue: 0.0,       alpha: 1.0),
            UIColor.init(red: 17/255.0,  green: 31/255.0,  blue: 106/255.0, alpha: 1.0)
        ]
        for i in 0...3 {
            let leftView = UIView.init(frame: CGRect(x: (dotSize.width + dotDistance)*CGFloat(i), y: 0.0, width: dotSize.width, height: dotSize.height))
            leftView.backgroundColor = leftDotColors[i]
            dotsLeftArray.append(leftView)
            self.addSubview(leftView)
            addAnimationForLeftLayerWithIndex(i, view: leftView)
        }
        
        for i in 0...3 {
            let rightView: UIView = UIView.init(frame: CGRect(x: self.bounds.width - dotSize.width - CGFloat(i)*(dotSize.width+dotDistance), y: 0.0, width: dotSize.width, height: dotSize.height))
            rightView.backgroundColor = rightDotColor[i]
            dotsRightArray.append(rightView)
            self.addSubview(rightView)
            addAnimationForRightViewWithIndex(i, view: rightView)
        }
    }
    
    private func addAnimationForLeftLayerWithIndex(index: NSInteger, view: UIView) {
        let scaleArray = [0.5, 0.6, 0.7, 0.9]
        let bezier = UIBezierPath()
        bezier.moveToPoint(CGPoint(x: view.center.x, y: self.bounds.height/4))
        bezier.addLineToPoint(CGPoint(x:self.bounds.width/2, y:self.bounds.height/4))
        bezier.closePath()
        
        let leftAnimation           = CAKeyframeAnimation.init(keyPath: "position")
        leftAnimation.duration      = 1.2
        leftAnimation.repeatCount   = MAXFLOAT
        leftAnimation.path          = bezier.CGPath
        
        let alphaAnimation          = CABasicAnimation.init(keyPath: "transform.scale")
        alphaAnimation.duration     = 1.2
        alphaAnimation.repeatCount  = MAXFLOAT
//        alphaAnimation.autoreverses = true
        alphaAnimation.fromValue    = 1.0
        alphaAnimation.toValue      = scaleArray[index]
        
        let animationGroup          = CAAnimationGroup.init()
        animationGroup.animations   = [leftAnimation, alphaAnimation]
        animationGroup.duration     = 2.4
        animationGroup.repeatCount  = MAXFLOAT
        
        view.layer.cornerRadius = view.frame.size.width/2
        view.layer.addAnimation(animationGroup, forKey: "group")
    }
    
    private func addAnimationForRightViewWithIndex(index: NSInteger, view: UIView) {
        let scaleArray = [0.5, 0.6, 0.7, 0.9]
        let bezier = UIBezierPath()
        bezier.moveToPoint(CGPoint(x: view.center.x, y: self.bounds.height/4))
        bezier.addLineToPoint(CGPoint(x:self.bounds.width/2, y:self.bounds.height/4))
        bezier.closePath()
        
        let leftAnimation           = CAKeyframeAnimation.init(keyPath: "position")
        leftAnimation.duration      = 1.2
        leftAnimation.repeatCount   = MAXFLOAT
        leftAnimation.path          = bezier.CGPath
        
        let alphaAnimation          = CABasicAnimation.init(keyPath: "transform.scale")
        alphaAnimation.duration     = 1.2
        alphaAnimation.repeatCount  = MAXFLOAT
//        alphaAnimation.autoreverses = true
        alphaAnimation.fromValue    = 1.0
        alphaAnimation.toValue      = scaleArray[index]
        
        let animationGroup          = CAAnimationGroup.init()
        animationGroup.animations   = [leftAnimation, alphaAnimation]
        animationGroup.duration     = 2.4
        animationGroup.repeatCount  = MAXFLOAT
        
        view.layer.cornerRadius = view.frame.size.width/2
        view.layer.addAnimation(animationGroup, forKey: "group")
    }
}
