//
//  WebKit.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 26.06.2024.
//

import SwiftUI
import WebKit

// WebView struct to open URLs and display the web page in the app
struct WebView: UIViewRepresentable {
    
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
