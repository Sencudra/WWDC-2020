
import UIKit

public protocol FontProvider {

    var mainFont: String { get }

}

// MARK: - Implementation

final class DefatulFontProvider: FontProvider {

    private let isMainFontRegistered: Bool = false

    var mainFont: String {
        if !isMainFontRegistered {
            let fontFileName = "SHPinscher"
            guard let url = Bundle.main.url(forResource: "SHPinscher", withExtension: "otf") else {
                fatalError("Unable to find font file \(fontFileName)")
            }
            CTFontManagerRegisterFontsForURL(url as CFURL, CTFontManagerScope.process, nil)
        }
        return "SH Pinscher"
    }

}
