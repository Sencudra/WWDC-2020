import Foundation
import UIKit

// MARK: - Protocol GameConfig

public protocol Config {

    var showFPS: Bool { get }
    var showNodeCount: Bool { get }
    var preferredContentSize: CGSize { get }
    var preferredFPS: Int { get }

}

// MARK: - Implementation

final class ConfigImpl: Config {

    // MARK: - Init

    var showFPS: Bool {
        return isDebug
    }

    var showNodeCount: Bool {
        return isDebug
    }

    var preferredContentSize: CGSize {
        // Some weird things are happening with the view with w/h > 700.
        return CGSize(width: 700, height: 700)
    }

    var preferredFPS: Int {
        return 60
    }

    // MARK: - Private properties

    private let isDebug: Bool

    // MARK: - Init

    init(isDebug: Bool = false) {
        self.isDebug = isDebug
    }

}
