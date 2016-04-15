//
//  ViewController.swift
//  XXRefreshControl
//
//  Created by Kxx.xxQ 一生相伴 on 16/4/15.
//  Copyright © 2016年 Asahi_Kuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listView: UITableView!
    
    lazy var itemsArray: Array = Array.init([])
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listView.delegate = self
        listView.dataSource = self
        listView.tableFooterView = UIView()
        
        itemsArray.append("Q弹动画刷新")
        itemsArray.append("韵律节奏动画")
        itemsArray.append("回弹动画")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: --
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("identifier")
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "identifier")
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.textLabel!.text = itemsArray[indexPath.row] as? String
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let refreshingVC = RefreshingViewController()
        let array = [XXRefreshingAnimationStyle.stretch, XXRefreshingAnimationStyle.rhythm, XXRefreshingAnimationStyle.flick]
        refreshingVC.style = array[indexPath.row]
        navigationController?.pushViewController(refreshingVC, animated: true)
    }



}

