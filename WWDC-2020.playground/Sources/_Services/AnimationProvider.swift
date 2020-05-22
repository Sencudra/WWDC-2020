
import SpriteKit

public protocol AnimationProvider {

    typealias SKAnimation = SKAction

    var playerHandUpAnimation: SKAnimation { get }
    var eyeRoundAnimation: SKAnimation { get }
    var eyeBlowAnimation: SKAnimation { get }
    var catAnimation: SKAnimation { get }

}

// MARK: - Implementation

final class AnimationProviderDefaultImpl: AnimationProvider {

    // MARK: - Properties

    var playerHandUpAnimation: SKAnimation {
        var frames = textureProvider.playerHandUpFrames
        frames = frames + frames.reversed()
        return SKAnimation.sequence([.animate(with: frames, timePerFrame: 0.1, resize: false, restore: true),
                                     .wait(forDuration: 2)])
    }

    var eyeRoundAnimation: SKAnimation {
        let frames = textureProvider.eyeFrames
        return SKAnimation.animate(with: frames, timePerFrame: 0.1, resize: false, restore: true)
    }

    var eyeBlowAnimation: SKAnimation {
        let frames = textureProvider.eyeBlowFrames
        return SKAnimation.animate(with: frames, timePerFrame: 0.1, resize: false, restore: true)
    }

    var catAnimation: SKAnimation {
        let frames = textureProvider.catFrames
        return SKAnimation.animate(with: frames, timePerFrame: 0.2, resize: false, restore: true)
    }

    // MARK: - Private properties

    private var textureProvider: TextureProvider

    // MARK: - Init

    init(textureProvider: TextureProvider) {
        self.textureProvider = textureProvider
    }

}
