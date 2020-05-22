
import SpriteKit

public protocol TextureProvider {

    var playerHandUpFrames: [SKTexture] { get }
    var playerHandUpShadow: SKTexture { get }
    var eyeFrames: [SKTexture] { get }
    var eyeBlowFrames: [SKTexture] { get }
    var roomMain: SKTexture { get }
    var catFrames: [SKTexture] { get }

}

// MARK: - Implementation

final class TextureProviderDefaultImpl: TextureProvider {

    // MARK: - Properties

    var playerHandUpFrames: [SKTexture] {
        return getAllFrames(from: playerHandUp, rows: 1, columns: 18)
    }

    var eyeFrames: [SKTexture] {
        return getAllFrames(from: eye, rows: 1, columns: 13)
    }

    var eyeBlowFrames: [SKTexture] {
        return getAllFrames(from: eyeBlow, rows: 1, columns: 9)
    }

    var catFrames: [SKTexture] {
        return getAllFrames(from: cat, rows: 1, columns: 11)
    }

    var roomMain: SKTexture {
        return SKTexture(imageNamed: "main_full.png")
    }

    var playerHandUpShadow: SKTexture {
        return SKTexture(imageNamed: "human_hand_up_shadow.png")
    }

    // MARK: - Private properties

    private var playerHandUp: SKTexture {
        return SKTexture(imageNamed: "human_hand_up_full.png")
    }

    private var eye: SKTexture {
        return SKTexture(imageNamed: "eyeFull.png")
    }

    private var eyeBlow: SKTexture {
        return SKTexture(imageNamed: "eyeFullBlow.png")
    }

    private var cat: SKTexture {
        return SKTexture(imageNamed: "cat.png")
    }

    // MARK: - Private methods

    private func getAllFrames(from texture: SKTexture,
                               rows: Int,
                               columns: Int,
                               spacing: CGFloat = 0,
                               margin: CGFloat = 0) -> [SKTexture] {

         let sheet = SpriteSheet(texture: texture,
                                rows: rows,
                                columns: columns,
                                spacing: spacing,
                                margin: margin)

         var frames = [SKTexture]()
         for row in 0..<rows {
             for column in 0..<columns {
                 if let texture = sheet.texture(column: column, row: row) {
                     frames.append(texture)
                 }
             }
         }
         return frames
    }

}
