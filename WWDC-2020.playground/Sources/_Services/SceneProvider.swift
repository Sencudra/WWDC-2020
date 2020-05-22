
import SpriteKit

public protocol SceneProvider {

    func makeIntroScene() -> IntroScene
    func makePresentationScene() -> PresentationScene
    func makeRoomScene() -> RoomScene
    func makeInteractiveScene() -> InteractiveScene
    func makeOutroFailScene() -> OutroFailScene
    func makeOutroSuccessScene() -> OutroSuccessScene

}

final class SceneProviderDefaultImpl: SceneProvider {

    // MARK: - Types

    struct Component {
        let logger: Logger
        let audioPlayer: AudioPlayer
        let textProvider: TextProvider
        let colorProvider: ColorProvider
        let audioProvider: AudioProvider
        let fontProvider: FontProvider
        let delaysProvider: DelaysProvider
        let textureProvider: TextureProvider
        let animationProvider: AnimationProvider
    }

    // MARK: - Private properties

    let component: Component

    // MARK: - Init

    init(component: Component) {
        self.component = component
    }

    // MARK: - Methods

    func makeIntroScene() -> IntroScene {
        return IntroScene(textProvider: component.textProvider,
                          colorProvider: component.colorProvider,
                          audioProvider: component.audioProvider,
                          fontProvider: component.fontProvider,
                          delaysProvider: component.delaysProvider)
    }

    func makePresentationScene() -> PresentationScene {
        return PresentationScene(textProvider: component.textProvider,
                                 colorProvider: component.colorProvider,
                                 audioProvider: component.audioProvider,
                                 fontProvider: component.fontProvider,
                                 delaysProvider: component.delaysProvider)
    }

    func makeRoomScene() -> RoomScene {
        return RoomScene(logger: component.logger,
                         audioPlayer: component.audioPlayer,
                         textProvider: component.textProvider,
                         colorProvider: component.colorProvider,
                         audioProvider: component.audioProvider,
                         fontProvider: component.fontProvider,
                         delaysProvider: component.delaysProvider,
                         textureProvider: component.textureProvider,
                         animationProvider: component.animationProvider)
    }

    func makeInteractiveScene() -> InteractiveScene {
        return InteractiveScene(logger: component.logger,
                                audioPlayer: component.audioPlayer,
                                textProvider: component.textProvider,
                                colorProvider: component.colorProvider,
                                audioProvider: component.audioProvider,
                                fontProvider: component.fontProvider,
                                delaysProvider: component.delaysProvider,
                                textureProvider: component.textureProvider,
                                animationProvider: component.animationProvider)
    }

    func makeOutroFailScene() -> OutroFailScene {
        return OutroFailScene(logger: component.logger,
                              audioPlayer: component.audioPlayer,
                              audioProvider: component.audioProvider,
                              textProvider: component.textProvider,
                              colorProvider: component.colorProvider,
                              fontProvider: component.fontProvider,
                              delaysProvider: component.delaysProvider)
    }

    func makeOutroSuccessScene() -> OutroSuccessScene {
        return OutroSuccessScene(logger: component.logger,
                                 audioPlayer: component.audioPlayer,
                                 audioProvider: component.audioProvider,
                                 textProvider: component.textProvider,
                                 colorProvider: component.colorProvider,
                                 fontProvider: component.fontProvider,
                                 delaysProvider: component.delaysProvider)
    }

}
