//
//  Sound.swift
//  Alien Life
//
//  Created by Muhammad Moaz on 2/5/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation
import AudioToolbox

extension Story {
    var SoundEffectName: String {
        switch self {
            case .droid, .home: return "HappyEnding"
            case .monster: return "Ominous"
            default: return "PageTurn"
        }
    }
    
    var soundEffectURL: URL {
        let path = Bundle.main.path(forResource: SoundEffectName, ofType: "wav")!
        return URL(fileURLWithPath: path)
    }
}

class Sound {
    var sound: SystemSoundID = 0
    
    func playSound(for story: Story) {
        let soundURL = story.soundEffectURL as CFURL
        
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}
