//
//  PlaySound.swift
//  Spyfall Pro
//
//  Created by John Zarogiannis on 19/7/20.
//  Copyright © 2020 John Zarogiannis. All rights reserved.
//

import Foundation
import AVFoundation

private var audioPlayer: AVAudioPlayer?

private func playSound(sound: String, type: String)
{
    DispatchQueue.global().async
    {
        if let path = Bundle.main.path(forResource: sound, ofType: type)
        {
            do
            {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            }
            catch { }
        }
    }
}

func playButtonClickSound()
{
    playSound(sound: "buttonClick", type: "mp3")
}

func playSliderClickSound()
{
    playSound(sound: "sliderClick", type: "mp3")
}

func playTimeOverSound()
{
    playSound(sound: "timeOver", type: "mp3")
}

func playGameStartedSound()
{
    playSound(sound: "gameStarted", type: "mp3")
}

func playToggleOffSound()
{
    playSound(sound: "toggleOff", type: "mp3")
}

func playToggleOnSound()
{
    playSound(sound: "toggleOn", type: "mp3")
}

func playPauseSound()
{
    playSound(sound: "pause", type: "mp3")
}

func playResumeSound()
{
    playSound(sound: "resume", type: "mp3")
}
