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
        
        
        // Add observer to receive a stop video notification
        NotificationCenter.default.addObserver(forName: NSNotification.Name("StopVideoPlayer"), object: nil, queue: .main) { _ in
            player.pause()
            controller.dismiss(animated: true, completion: nil)
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Stays empty for now
    }
    
    // Clean up observer when not needed
    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: ()) {
        NotificationCenter.default.removeObserver(uiViewController, name: NSNotification.Name("StopVideoPlayer"), object: nil)
    }
}

#Preview {
    VideoPlayerView(videoURL: URL(string: "https://www.youtube.com/watch?v=546ufMY7488")!)
}
