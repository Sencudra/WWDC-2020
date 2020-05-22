import Foundation

public protocol Story {

    var config: Config { get }
    var logger: Logger { get }
    var audioPlayer: AudioPlayer { get }

    var audioProvider: AudioProvider { get }
    var textProvider: TextProvider { get }
    var colorProvider: ColorProvider { get }
    var fontProvider: FontProvider { get }
    var sceneProvider: SceneProvider { get }
    var delaysProvider: DelaysProvider { get }
    var textureProvider: TextureProvider { get }
    var animationProvider: AnimationProvider { get }

}

// MARK: - Implementation

public class DefaultStory: Story {

    // MARK: - Internal properties

    public let config: Config
    public let logger: Logger
    public let audioPlayer: AudioPlayer
    public let audioProvider: AudioProvider
    public let textProvider: TextProvider
    public let colorProvider: ColorProvider
    public let fontProvider: FontProvider
    public let sceneProvider: SceneProvider
    public let delaysProvider: DelaysProvider
    public let textureProvider: TextureProvider
    public let animationProvider: AnimationProvider

    // MARK: - Init

    public init(isDebug: Bool = false) {
        self.config = ConfigImpl(isDebug: isDebug)
        self.logger = DefaultLogger(isDebug: isDebug)
        self.audioPlayer = AudioPlayerImpl(logger: self.logger)
        self.audioProvider = DefaultAudioProvider()
        self.colorProvider = DefaultColorProvider()
        self.textProvider = DefaultTextProvider()
        self.fontProvider = DefatulFontProvider()
        self.delaysProvider = DelaysProviderDefaultImpl()
        self.textureProvider = TextureProviderDefaultImpl()
        self.animationProvider = AnimationProviderDefaultImpl(textureProvider: textureProvider)
        self.sceneProvider = SceneProviderDefaultImpl(component: .init(logger: logger,
                                                                       audioPlayer: audioPlayer,
                                                                       textProvider: textProvider,
                                                                       colorProvider: colorProvider,
                                                                       audioProvider: audioProvider,
                                                                       fontProvider: fontProvider,
                                                                       delaysProvider: delaysProvider,
                                                                       textureProvider: textureProvider,
                                                                       animationProvider: animationProvider))
    }

}
