//
//  XXRefreshingRhythmAnimation.swift
//  XXAnimation
//
//  Created by Kxx.xxQ 一生相伴 on 16/4/15.
//  Copyright © 2016年 Asahi_Kuang. All rights reserved.
//

import UIKit

class XXRefreshingRhythmAnimation: UIView {

    private var numberOfItems: NSInteger
    private var itemWidth    : CGFloat
    private var itemHeight   : CGFloat
    private let itemDistance : CGFloat = 2.0
    
    private lazy var elementsArray: Array<UIView> = Array.init([])
    
    init(frame: CGRect, _numberOfItems: NSInteger, _itemWidth: CGFloat, _itemHeight: CGFloat) {
        
        numberOfItems = _numberOfItems
        itemWidth     = _itemWidth
        itemHeight    = _itemHeight
        
        super.init(frame: frame)
        buildUpAnimationView(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginRefreshing() {
        for i in 0..<self.elementsArray.count {
            let v: UIView = self.elementsArray[i]
            addAnimationForViewAtIndex(i, layer: v.layer)
        }
    }
    
    func endRefreshing() {
        
        for i in 0..<self.elementsArray.count {
            let v: UIView = self.elementsArray[i]
            v.layer.removeAllAnimations()
        }
    }
    
    private func buildUpAnimationView(frame: CGRect) {
        let colorArray: Array<UIColor> =
        [
                UIColor.init(red: 2/255.0,   green: 130/255.0, blue: 85/255.0,  alpha: 1.0),
                UIColor.init(red: 153/255.0, green: 241/255.0, blue: 88/255.0,  alpha: 1.0),
                UIColor.init(red: 221/255.0, green: 55/255.0,  blue: 0.0,       alpha: 1.0),
                UIColor.init(red: 44/255.0,  green: 128/255.0, blue: 197/255.0, alpha: 1.0),
                UIColor.init(red: 17/255.0,  green: 31/255.0,  blue: 106/255.0, alpha: 1.0),
                UIColor.blackColor()
        ]
        for i in 0..<numberOfItems {
            let itemView = UIView.init(frame: CGRect(x: (frame.width/2 - 12.0 - CGFloat(numberOfItems/2)*(itemWidth+itemDistance)) + CGFloat(i)*(CGFloat(numberOfItems)+itemWidth), y: frame.height, width: itemWidth, height: itemHeight))
            itemView.backgroundColor = colorArray[i]
            self.addSubview(itemView)
            elementsArray.append(itemView)
        }
    }
    
    
    private func addAnimationForViewAtIndex(index: NSInteger, layer: CALayer) {
        let durations          = [0.6, 0.4, 0.7, 0.5, 0.9, 0.8]
        let animation          = CABasicAnimation.init(keyPath: "transform.scale.y")
        animation.duration     = durations[index]
        animation.repeatCount  = MAXFLOAT
        animation.fromValue    = 1.0
        animation.toValue      = 0.1
        animation.autoreverses = true
        
        layer.anchorPoint      = CGPoint(x: 0.0, y: 1.0)
        layer.addAnimation(animation, forKey: "scale.y")
    }
}
