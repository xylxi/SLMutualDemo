//
//  SLXHViewController.swift
//  SLMutualDemo
//
//  Created by DMW_W on 16/7/15.
//  Copyright © 2016年 XYLXI. All rights reserved.
//

import UIKit

class SLXHViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indiView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indiView.startAnimating()
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.xianhua.com.cn/m/")!));
        self.webView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SLXHViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
        self.indiView.stopAnimating()
        let removeDownJS = "document.getElementsByClassName('detail_btns2')[0].remove()"
        webView.stringByEvaluatingJavaScriptFromString(removeDownJS)
        
        let titleJS = "document.getElementsByTagName('h1')[0].innerText=\"修改了标题\""
        webView.stringByEvaluatingJavaScriptFromString(titleJS)
    }
}
