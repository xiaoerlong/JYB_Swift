//
//  JYBWebViewController.swift
//  JYB_Swift
//
//  Created by kim on 2021/1/26.
//

import UIKit
import WebKit

/// web页面
class JYBWebViewController: UIViewController {
    
    private let kEnlargePicture = "enlargePricte"
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration.init()
        let versionStr = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        configuration.applicationNameForUserAgent = "jybVersion:" + versionStr
        
        let webView = WKWebView.init(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        return webView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        return progressView
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        let url = URL(string:"https://www.baidu.com")!
        loadRequest(url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userContentController = webView.configuration.userContentController
        userContentController.add(self, name: kEnlargePicture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let userContentController = webView.configuration.userContentController
        userContentController.removeScriptMessageHandler(forName: kEnlargePicture)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "loading")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
    
    // MARK: Private
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(progressView)
        view.insertSubview(webView, belowSubview: progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(2)
        }
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    func loadRequest(_ url: URL) {
        webView.load(URLRequest.init(url: url))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            print("正在加载")
        } else if keyPath == "estimatedProgress" {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        } else if keyPath == "title" {
            navigationItem.title = webView.title
        }
    }

}

// 处理导航事件，包括载入错误
extension JYBWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    // 载入错误时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // 页面载入完毕后执行
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
    
    // 网页加载由一个动作(Action)触发，然后请求被发送到服务器，得到一个响应，最后服务器会发送更多的数据，并结束加载过程
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated && !(navigationAction.request.url?.host?.lowercased().hasPrefix("www.appcoda.com"))! {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

extension JYBWebViewController: WKUIDelegate {
    
}

extension JYBWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // 查看大图
        if message.name == kEnlargePicture {
            guard let info = message.body as? [String: Any] else {
                return
            }
            guard let srcList = info["srcList"] as? [String] else {
                return
            }
            print(srcList)
        }
    }
    
}
