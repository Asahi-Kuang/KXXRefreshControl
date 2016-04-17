//
//  RefreshingViewController.swift
//  XXAnimation
//
//  Created by Kxx.xxQ 一生相伴 on 16/4/15.
//  Copyright © 2016年 Asahi_Kuang. All rights reserved.
//

import UIKit

class RefreshingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
            frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 80.0),
            backgroundColor: UIColor.init(red: 235/255.0, green: 127/255.0, blue: 175/255.0, alpha: 0.3),
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
        listView = UITableView.init(frame: CGRect(x: 0.0, y: -80, width: self.view.bounds.width, height: self.view.bounds.height-80.0), style: .Plain)
        listView!.tableFooterView = UIView()
        listView!.dataSource = self
        listView!.delegate = self
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
    
    // MARK: - UITableViewDataSource && delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 8 }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("identifier")
        if cell == nil {
            cell = UITableViewCell.init(style: .Value1, reuseIdentifier: "identifier")
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let text = ["Objective-C", "Swift", "Python", "C#", "C++", "Javascript", "HTML5", "..."]
        let text2 = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "..."]
        cell.textLabel!.text = text[indexPath.row]
        cell.detailTextLabel!.text = text2[indexPath.row]
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat { return 55 }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
