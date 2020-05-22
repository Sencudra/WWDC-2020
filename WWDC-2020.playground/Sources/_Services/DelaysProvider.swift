import Foundation

public protocol DelaysProvider {

    var introFadeIn: TimeInterval { get }
    var introWaiting: TimeInterval { get }
    var presentationFadeIn: TimeInterval { get }
    var presentationWaiting: TimeInterval { get }
    var sceneFadeIn: TimeInterval { get }
    var interactiveFadeIn: TimeInterval { get }
    var outroFailBlackWaiting: TimeInterval { get }
    var outroFailFadeIn: TimeInterval { get }
    var outroSuccessFadeIn: TimeInterval { get }
}

// MARK: - Implementation

final class DelaysProviderDefaultImpl: DelaysProvider {

    // MARK: - Internal properties

    var introFadeIn: TimeInterval {
        return 5.0
    }

    var introWaiting: TimeInterval {
        return 7.0
    }

    var presentationFadeIn: TimeInterval {
        return 1.0
    }

    var presentationWaiting: TimeInterval {
        return 20.0
    }

    var sceneFadeIn: TimeInterval {
        return 0.0
    }

    var interactiveFadeIn: TimeInterval {
        return 5.0
    }

    var outroSuccessFadeIn: TimeInterval {
        return 0.1
    }

    var outroFailBlackWaiting: TimeInterval {
        return 2.0
    }

    var outroFailFadeIn: TimeInterval {
        return 5.0
    }

}
