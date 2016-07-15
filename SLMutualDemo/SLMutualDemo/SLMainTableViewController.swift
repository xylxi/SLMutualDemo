//
//  SLMainTableViewController.swift
//  SLMutualDemo
//
//  Created by DMW_W on 16/7/15.
//  Copyright © 2016年 XYLXI. All rights reserved.
//

import UIKit

class SLMainTableViewController: UITableViewController {

    var dataArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArr.appendContentsOf(["网易新闻页","鲜花网"])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        cell.textLabel?.text = "OC与WebView交互之" + self.dataArr[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(self.dataArr[indexPath.row], sender: nil);
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
