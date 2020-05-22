import SpriteKit

public protocol ColorProvider {

    var backgroundColor: SKColor { get }

}

// MARK: - Implementation

final class DefaultColorProvider: ColorProvider {

    // MARK: - Internal properties

    var backgroundColor: SKColor {
        return #colorLiteral(red: 0.0108004678, green: 0.05997823179, blue: 0.1002132669, alpha: 1)
    }

}
