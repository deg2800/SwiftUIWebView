//
//  WebView.swift
//  SwiftUIWebView
//
//  Created by Derrick Goodfriend on 10/28/24.
//

import SwiftUI
@preconcurrency import WebKit

public struct WebView: NSViewRepresentable {
    @ObservedObject public var model: WebViewModel
    
    public init(model: WebViewModel) {
            self.model = model
    }
    
    public class Coordinator: NSObject, WKNavigationDelegate {
        public var parent: WebView
        public var webView: WKWebView?
        
        public init(parent: WebView) {
            self.parent = parent
        }
        
        public func goBack() {
            if webView?.canGoBack == true {
                webView?.goBack()
            }
        }
        
        public func goForward() {
            if webView?.canGoForward == true {
                webView?.goForward()
            }
        }
        
        public func reloadPage() {
            webView?.reload()
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.model.isLoading = false
            }
        }
        
        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let newURL = navigationAction.request.url {
                DispatchQueue.main.async {
                    self.parent.model.url = newURL
                }
            }
            decisionHandler(.allow)
        }
        
        public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "title", let webView = object as? WKWebView, let title = webView.title {
                DispatchQueue.main.async {
                    self.parent.model.pageTitle = title
                }
            }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        context.coordinator.webView = webView
        webView.navigationDelegate = context.coordinator
        webView.addObserver(context.coordinator, forKeyPath: "title", options: .new, context: nil)
        webView.load(URLRequest(url: model.url))
        return webView
    }
    
    public func updateNSView(_ nsView: WKWebView, context: Context) {
        if nsView.url != model.url {
            nsView.load(URLRequest(url: model.url))
        }
        
        switch model.action {
        case .forward:
            context.coordinator.goForward()
        case .back:
            context.coordinator.goBack()
        case .reload:
            context.coordinator.reloadPage()
        case .stop:
            nsView.stopLoading()
        default:
            break
        }
        
        DispatchQueue.main.async {
            model.action = .none
            model.backForwardList = nsView.backForwardList
        }
    }
}

