
import Foundation

public protocol AudioProvider {

    var background: URL { get }
    var hit: URL { get }
    var gameOverTheme: URL { get }
    var gameOverSound: URL { get }
    var buttonPressed: URL { get }
    var outroMainTheme: URL { get }
    var fightTheme: URL { get }

}

// MARK: - Implementation

final class DefaultAudioProvider: AudioProvider {

    // MARK: - Internal properties

    // Intro

    var background: URL {
        return URL(fileURLWithPath: "background.mp3")
    }

    // Interactive

    var hit: URL {
        return URL(fileURLWithPath: "hit.wav")
    }

    var fightTheme: URL {
        return URL(fileURLWithPath: "fight.mp3")
    }

    // Outro fail

    var gameOverTheme: URL {
        return URL(fileURLWithPath: "gameOverTheme.mp3")
    }

    var gameOverSound: URL {
        return URL(fileURLWithPath: "gameOverSound.wav")
    }

    var buttonPressed: URL {
        return URL(fileURLWithPath: "buttonPress.wav")
    }

    // Outro success

    var outroMainTheme: URL {
        return URL(fileURLWithPath: "final.mp3")
    }

}
