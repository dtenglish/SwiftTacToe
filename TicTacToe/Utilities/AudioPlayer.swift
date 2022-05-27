//
//  AudioPlayer.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/27/22.
//

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer?

let feedback = UINotificationFeedbackGenerator()

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            feedback.notificationOccurred(.success)
        } catch {
            print("Could not find and play audio file.")
        }
    }
}
