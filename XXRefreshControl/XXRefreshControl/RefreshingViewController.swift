//
//  RefreshingViewController.swift
//  XXAnimation
//
//  Created by Kxx.xxQ 一生相伴 on 16/4/15.
//  Copyright © 2016年 Asahi_Kuang. All rights reserved.
//

import UIKit

class RefreshingViewController: UIViewController {
    
    var listView               : UITableView?
    var style                  : XXRefreshingAnimationStyle?
    var refreshingView         : XXRefreshView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        originalSetting()
        addRefreshingView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshingView!.beginRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRefreshingView() {
//        style = XXRefreshingAnimationStyle.stretch
        refreshingView = XXRefreshView.init(
            frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 60.0),
            backgroundColor: UIColor.init(red: 230/255.0, green: 1.0, blue: 253/255.0, alpha: 1.0),
            refreshingTipText: "正在努力刷新中哟(づ｡◕‿‿◕｡)づ",
            refreshingTipTextColor: UIColor.orangeColor(),
            completeTipText: "刷新成功!",
            completeTipTextColor: UIColor.blackColor(),
            fontSize: 12.0,
            dateSize: 10.0,
            dateColor: UIColor.blackColor(),
            animationStyle: self.style!)
        listView!.tableHeaderView = refreshingView
    }
    
    func originalSetting() {
        //
        self.view.backgroundColor = UIColor.whiteColor()
        listView = UITableView.init(frame: CGRect(x: 0.0, y: -60, width: self.view.bounds.width, height: self.view.bounds.height-60.0), style: .Plain)
        listView!.tableFooterView = UIView()
        self.view.addSubview(listView!)

        
        let refreshButton   = UIButton.init(type: .Custom)
        refreshButton.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
        refreshButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        refreshButton.setTitle("刷新", forState: .Normal)
        refreshButton.addTarget(self, action: #selector(refresh), forControlEvents: .TouchUpInside)
        let endButton       = UIButton.init(type: .Custom)
        endButton.frame     = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
        endButton.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        endButton.addTarget(self, action: #selector(end), forControlEvents: .TouchUpInside)
        endButton.setTitle("结束", forState: .Normal)
        let barButtonLeft   = UIBarButtonItem.init(customView: refreshButton)
        let barButtonRight  = UIBarButtonItem.init(customView: endButton)
        navigationItem.setRightBarButtonItems([barButtonLeft, barButtonRight], animated: false)
    }
    
    func refresh() {
        refreshingView!.beginRefreshing()
    }
    
    func end() {
        refreshingView!.endRefreshing()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
