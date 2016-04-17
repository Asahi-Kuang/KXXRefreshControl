//
//  XXRefreshView.swift
//  XXAnimation
//
//  Created by Kxx.xxQ 一生相伴 on 16/4/14.
//  Copyright © 2016年 Asahi_Kuang. All rights reserved.
//

import UIKit

enum XXRefreshingAnimationStyle {
    case stretch
    case rhythm
    case flick
}

class XXRefreshView: UIView, UITableViewDelegate {

    private var textLayer          : CATextLayer?
    private var timeTextLayer      : CATextLayer?
    private var style              : XXRefreshingAnimationStyle
    private var refreshingTextColor: UIColor
    private var completeTextColor  : UIColor
    private var refreshingText     : String
    private var completeText       : String
    private var dateTextColor      : UIColor
    private var dateTextFont       : CGFloat
    private var font               : CGFloat
    private var tableView          : UITableView?
    
    private var stretchAniView     : XXRefreshingStrechAnimation?
    private var rhythmAniView      : XXRefreshingRhythmAnimation?
    private var flickAniView       : XXRefreshingFlickAnimation?
    
    init(frame: CGRect, backgroundColor: UIColor, refreshingTipText: String, refreshingTipTextColor: UIColor, completeTipText: String, completeTipTextColor: UIColor, fontSize:CGFloat, dateSize: CGFloat, dateColor: UIColor, animationStyle: XXRefreshingAnimationStyle) {
        //
        refreshingTextColor  = refreshingTipTextColor
        completeTextColor    = completeTipTextColor
        refreshingText       = refreshingTipText
        completeText         = completeTipText
        style                = animationStyle
        font                 = fontSize
        dateTextFont         = dateSize
        dateTextColor        = dateColor
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        
        buildTipLable()
        buildRefreshTime()
        
        switch animationStyle {
        case .rhythm:
            //
            buildRhythmAnimationView()
            break
        case .flick:
            buildFilckAnimationView()
            break
        default:
            //
            buildStrechAnimationView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildTipLable() {
        textLayer = CATextLayer()
        textLayer!.frame = CGRect(x: 0.0, y: CGRectGetHeight(self.frame)/4+15, width:self.bounds.width, height:CGRectGetHeight(self.frame)/4*3-15)
        textLayer!.string = refreshingText
        textLayer!.contentsScale = 2.0
        textLayer!.foregroundColor = UIColor.redColor().CGColor
        textLayer!.fontSize = font
        textLayer!.alignmentMode = kCAAlignmentCenter
        
        self.layer.insertSublayer(textLayer!, atIndex: 0)
    }
    
    private func buildRefreshTime() {
        
        timeTextLayer = CATextLayer()
        timeTextLayer!.frame = CGRect(x: 0.0, y: CGRectGetHeight(self.frame)/4*3, width:self.bounds.width, height:CGRectGetHeight(self.frame)/4)
        timeTextLayer!.string = ""
        timeTextLayer!.contentsScale = 2.0
        timeTextLayer!.foregroundColor = dateTextColor.CGColor
        timeTextLayer!.fontSize = dateTextFont
        timeTextLayer!.alignmentMode = kCAAlignmentCenter
        
        self.layer.insertSublayer(timeTextLayer!, atIndex: 0)
    }
    
    private func getRefreshTime() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateNow = NSDate()
        let dateString = formatter.stringFromDate(dateNow)
        return "上次刷新于:"+" "+dateString
    }
    
    private func buildFilckAnimationView() {
        flickAniView = XXRefreshingFlickAnimation.init(frame: CGRect(x: 0.0, y: CGRectGetHeight(self.frame)/4, width: self.bounds.width, height: self.bounds.height/4-15), _dotSize: CGSize(width: 15.0, height: 15.0), _dotDistance: 10.0)
        self.addSubview(flickAniView!)
    }
    
    private func buildStrechAnimationView() {
        stretchAniView = XXRefreshingStrechAnimation.init(frame: CGRect(x: 0.0, y: CGRectGetHeight(self.frame)/4, width: self.bounds.width, height: self.bounds.height/4-15), dotSize: CGSize(width: 15.0, height: 15.0), dotDistance: 20.0)
        self.addSubview(stretchAniView!)
    }
    
    private func buildRhythmAnimationView() {
        rhythmAniView = XXRefreshingRhythmAnimation.init(frame: CGRect(x: 0.0, y: CGRectGetHeight(self.frame)/4, width: self.bounds.width, height: self.bounds.height/4-15), _numberOfItems: 6, _itemWidth: 10, _itemHeight: 25)
        self.addSubview(rhythmAniView!)
    }
    
    func beginRefreshing() {
        
        if self.superview == nil { return }
        if !self.superview!.isKindOfClass(UIScrollView) { return }
        
        tableView = self.superview as? UITableView
        tableView!.delegate = self
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {
            //
            self.tableView!.transform = CGAffineTransformMakeTranslation(0.0, self.bounds.height)
            self.textLayer!.string = self.refreshingText
            
            
            switch self.style {
            case .rhythm:
                //
                self.rhythmAniView!.beginRefreshing()
                break
            case .flick:
                self.flickAniView!.beginRefreshing()
                break
            default:
                //
                self.stretchAniView!.beginRefreshing()
            }
            }) { (isCompleted) in
                //
        }
        
    }
    
    func endRefreshing() {
        
        self.textLayer!.string = self.completeText
        UIView.animateWithDuration(0.3, delay: 1.0, options: [], animations: {
            //
            self.tableView!.transform = CGAffineTransformMakeTranslation(0.0, 0.0)
            
        }) { (isCompleted) in
            //
            switch self.style {
            case .rhythm:
                //
                self.rhythmAniView!.endRefreshing()
                break
            case .flick:
                //
                self.flickAniView!.endRefreshing()
                break
            default:
                //
                self.stretchAniView!.endRefreshing()
            }
            
            // 刷新时间
            self.timeTextLayer!.string = self.getRefreshTime()
        }
        
        
    }
    
    
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        //
        if scrollView.contentOffset.y < -self.bounds.height*2 {
            beginRefreshing()
        }
    }
}
