
import SpriteKit
import Foundation

enum PhysicsCategory: UInt32 {
    case none = 0x0
    case character = 0x1
    case eye = 0x10
    case all = 0xFFFFFFFF
}

