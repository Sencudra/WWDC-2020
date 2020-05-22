import Foundation
import SpriteKit
import AVFoundation

public protocol AudioPlayer {

    func playMusic(file: URL, volume: Float, fadeDuration: TimeInterval)
    func stopMusic()
    func pauseMusic()
    func resumeMusic()
    func playSoundEffect(file: URL)

}

// MARK: - Implementation

final class AudioPlayerImpl: AudioPlayer {

    // MARK: - Private properties

    private let logger: Logger
    private var musicPlayer: AVAudioPlayer!
    private var soundPlayer: AVAudioPlayer!

    // MARK: - Init

    init(logger: Logger) {
        self.logger = logger
    }

    // MARK: - Methods

    func playMusic(file: URL, volume: Float, fadeDuration: TimeInterval) {
        if let url = Bundle.main.url(forResource: file.relativeString, withExtension: "") {
            musicPlayer = try? AVAudioPlayer(contentsOf: url)
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            musicPlayer.setVolume(volume, fadeDuration: fadeDuration)
        } else {
            logger.log(warning: "Unable to find music file for \(file)")
        }
    }

    func stopMusic() {
        if musicPlayer != nil && musicPlayer!.isPlaying {
            musicPlayer.currentTime = 0
            musicPlayer.stop()
        }
    }

    func pauseMusic() {
        if musicPlayer != nil && musicPlayer!.isPlaying {
            musicPlayer.pause()
        }
    }

    func resumeMusic() {
        if musicPlayer != nil && !musicPlayer!.isPlaying {
            musicPlayer.play()
        }
    }

    func playSoundEffect(file: URL) {
        if let url = Bundle.main.url(forResource: file.relativeString, withExtension: "") {
            soundPlayer = try? AVAudioPlayer(contentsOf: url)
            soundPlayer.stop()
            soundPlayer.currentTime = 0.0
            soundPlayer.numberOfLoops = 0
            soundPlayer.volume = 1
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        }
    }

}
