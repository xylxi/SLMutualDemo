//
//  ViewController.swift
//  SLMutualDemo
//
//  Created by DMW_W on 16/7/14.
//  Copyright © 2016年 XYLXI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var indiView: UIActivityIndicatorView!
    let url   = NSURL(string: "http://c.3g.163.com/nc/article/BMU8KHQD00964J4O/full.html")!
    let token = "BMU8KHQD00964J4O";
    var task: NSURLSessionDataTask!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self;
        
        self.indiView.startAnimating()
        self.indiView.hidesWhenStopped = true
        
        self.task = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()).dataTaskWithURL(self.url) { (data, response, error) in
                if let data = data {
                    let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                    self.getHtmlByDict(dict)
                }
            };
        self.task.resume();
    }
    
    func getHtmlByDict(dict: NSDictionary) {
        let dataDict = dict[self.token] as! NSDictionary
        let title  = dataDict["title"] as! String
        let time   = dataDict["ptime"] as! String
        let source = dataDict["source"] as! String
        var content   = dataDict["body"] as! NSString
        // 图片数据
        let imgs   = dataDict["img"] as! [[String : AnyObject]]
        for i in 0..<imgs.count {
            let img = imgs[i]
            let imgTitle = img["alt"] as! String
            let ref = img["ref"] as! String
            let src = img["src"] as! String
            let imgHtml = "<div class=\"all-img\"><img src=\"\(src)\"><div>\(imgTitle)</div>"
            content = content.stringByReplacingOccurrencesOfString(ref, withString: imgHtml)
        }
        // 标题
        let titleHtml = "<div id=\"title\">\(title)</div>"
        // 时间
        let subTitleHtml = "<div id=\"subTitle\"><span>\(source)</span><span>\(time)</span></div>"
        // css
        let cssurl = NSBundle.mainBundle().URLForResource("news", withExtension: "css")!
        let cssHtml = "<link href=\"\(cssurl)\" rel=\"stylesheet\">"
        
        // js
        let jsurl = NSBundle.mainBundle().URLForResource("news", withExtension: "js")!
        let jsHtml = "<script src=\"\(jsurl)\"></script>"
        
        let html  = "<html><head>\(cssHtml)</head><body>\(titleHtml)\(subTitleHtml)\(content)\(jsHtml )</body></html>"
        
        self.webView.loadHTMLString(html, baseURL: nil)
        
        self.indiView.stopAnimating()
    }
    
    func method(url: String) {
        let arr = (url as NSString).componentsSeparatedByString("_")
        let frame = CGRect(x: Int(arr[0])!, y: Int(arr[1])!, width: Int(arr[2])!, height: Int(arr[3])!)
        print(frame)
    }

}

extension ViewController: UIWebViewDelegate {
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let locationUrl = "location://"
        if let urlString = request.URL?.absoluteString  where urlString.hasPrefix(locationUrl) {
            let arg = (urlString as NSString).stringByReplacingOccurrencesOfString("location://method:", withString: "")
            let sel = NSSelectorFromString("method:")
            self.performSelector(sel, withObject: arg)
            return false
        }else {
            return true
        }
    }
}


