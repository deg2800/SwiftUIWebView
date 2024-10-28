//
//  WebViewModel.swift
//  SwiftUIWebView
//
//  Created by Derrick Goodfriend on 10/28/24.
//

import SwiftUI
@preconcurrency import WebKit

public class WebViewModel: ObservableObject {
    @Published public var url: URL
    @Published public var pageTitle: String = ""
    @Published public var action: BrowserAction = .none
    @Published public var backForwardList: WKBackForwardList?
    @Published public var isLoading: Bool = false
    
    public init(url: URL) {
        self.url = url
    }
    
    public func goBack() { action = .back }
    public func goForward() { action = .forward }
    public func reload() { action = .reload }
    public func stopLoading() { action = .stop }
}
