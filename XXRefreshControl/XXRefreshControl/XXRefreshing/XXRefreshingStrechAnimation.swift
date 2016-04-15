//
//  XXRefreshingStrechAnimation.swift
//  XXAnimation
//
//  Created by Kxx.xxQ 一生相伴 on 16/4/15.
//  Copyright © 2016年 Asahi_Kuang. All rights reserved.
//

import UIKit

class XXRefreshingStrechAnimation: UIView {

    private lazy var elementsArray: Array<UIView> = Array.init([])
    private lazy var positonsArray: Array<CGPoint>= Array.init([])
    private lazy var scalesArray  : Array<Double> = Array.init([])
    
    private var _dotSize           : CGSize
    private var _dotDistance       : CGFloat

    init(frame: CGRect, dotSize: CGSize, dotDistance: CGFloat) {
        //
        _dotSize     = dotSize
        _dotDistance = dotDistance
        super.init(frame: frame)
        buildUpAnimationLoadingView(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUpAnimationLoadingView(frame: CGRect) {
        
        let centerX = CGRectGetWidth(frame)/2 - _dotDistance*2
        let centerY = CGRectGetHeight(self.frame)/4
        
        let colorArray: Array<UIColor> =
        [
                UIColor.init(red: 2/255.0,   green: 130/255.0, blue: 85/255.0,  alpha: 1.0),
                UIColor.init(red: 153/255.0, green: 241/255.0, blue: 88/255.0,  alpha: 1.0),
                UIColor.init(red: 221/255.0, green: 55/255.0,  blue: 0.0,       alpha: 1.0),
                UIColor.init(red: 44/255.0,  green: 128/255.0, blue: 197/255.0, alpha: 1.0),
                UIColor.init(red: 17/255.0,  green: 31/255.0,  blue: 106/255.0, alpha: 1.0)
        ]
        
        let centerView = UIView.init(frame: CGRect(x: 0.0, y: 0.0, width: _dotSize.width, height:  _dotSize.height))
        centerView.center = CGPoint(x: centerX, y: centerY)
        centerView.backgroundColor = colorArray[0]
        self.addSubview(centerView)
        elementsArray.append(centerView)
        
        positonsArray.append(centerView.center)
        scalesArray = [0.5, 0.3, 0.7, 0.3, 0.5]
        for i in 0..<(colorArray.count-1) {
            let view = UIView.init(frame: CGRect(x: 0.0, y: 0.0, width: _dotSize.width, height: _dotSize.height))
            view.center = CGPoint(x: centerView.center.x+(_dotDistance*CGFloat(i+1)), y:centerY)
            view.backgroundColor = colorArray[i+1]
            self.addSubview(view)
            elementsArray.append(view)
            positonsArray.append(view.center)
        }
    }
    
    func beginRefreshing() {
        for i in (0..<self.elementsArray.count).reverse() {
            let v: UIView = self.elementsArray[i]
            v.layer.cornerRadius = self._dotSize.height/2
            self.addAnimationForViewWithIndex(v, index: i)
        }
    }
    
    func endRefreshing() {
        
        for i in (0..<self.elementsArray.count).reverse() {
            let v: UIView = self.elementsArray[i]
            v.layer.cornerRadius = 0.0
            v.layer.removeAllAnimations()
        }
    }
    
    private func addAnimationForViewWithIndex(view: UIView, index:NSInteger) {
        let animation               = CABasicAnimation.init(keyPath: "position")
        animation.fromValue         = NSValue.init(CGPoint: positonsArray[abs(index-4)])
        animation.toValue           = NSValue.init(CGPoint: positonsArray[index])
        animation.duration          = 0.85
        animation.repeatCount       = MAXFLOAT
        animation.autoreverses      = true
        
        let animationScale          = CABasicAnimation.init(keyPath: "transform.scale")
        animationScale.fromValue    = 1.0
        animationScale.toValue      = scalesArray[abs(index-4)]
        animationScale.duration     = 0.85
        animationScale.repeatCount  = MAXFLOAT
        animationScale.autoreverses = true
        
        let animationGroup          = CAAnimationGroup.init()
        animationGroup.animations   = [animation, animationScale]
        animationGroup.duration     = 1.7
        animationGroup.repeatCount  = MAXFLOAT
        animationGroup.autoreverses = true
        
        view.layer.addAnimation(animationGroup, forKey: "group")
    }
    
}
