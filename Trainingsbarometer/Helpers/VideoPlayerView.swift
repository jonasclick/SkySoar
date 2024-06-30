//
//  VideoPlayerView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 30.06.2024.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoPlayerView: UIViewControllerRepresentable {
    
    var videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: videoURL)
        
        controller.player = player
        player.play()
        
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Stays empty for now
    }
}

#Preview {
    VideoPlayerView(videoURL: URL(string: "https://www.youtube.com/watch?v=546ufMY7488")!)
}
