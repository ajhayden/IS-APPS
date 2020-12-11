//
//  WebView.swift
//  MappedScriptures
//
//  Created by Student on 12/5/20.
//

import SwiftUI
import WebKit

// Contains the coordinator nessecary to display all geo location points
struct WebView: UIViewRepresentable {
    let html: String?
    let request: URLRequest?
    
    private let coordinator = Coordinator()
    
    func injectNavigationHandler(_ handler: @escaping (Int) -> Void) -> some View {
        coordinator.navigationHandler = handler
        
        return self
    }
    
    func makeCoordinator() -> Coordinator {
        coordinator
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.navigationDelegate = coordinator
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let html = self.html {
            uiView.loadHTMLString(html, baseURL: nil)
        }
        
        if let request = self.request {
            uiView.load(request)
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var navigationHandler: ((Int) -> Void)? = nil
        
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                if url.absoluteString.starts(with: WebView.placeUrl) {
                    decisionHandler(.cancel)
                    
                    if let handler = navigationHandler {
                        let geoPlaceId = Int(url.absoluteString.substring(fromOffset: WebView.placeUrl.count)) ?? 0
                        
                        handler(geoPlaceId)
                    }
                    return
                }
            }
            
            decisionHandler(.allow)
        }
    }
    
    static let placeUrl = "https://scriptures.byu.edu/mapscrip/"
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(html: nil, request: URLRequest(url: URL(string: "https://www.byu.edu")!))
    }
}
