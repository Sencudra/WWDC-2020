import SpriteKit

protocol SceneHandler: AnyObject {

    func didEndIntro()
    func didEndPresentation()
    func didEndRoom()

    func didPressFailOutroAcceptButton()
    func didPressFailOutroRefuseButton()

    func didFailInteractive()
    func didSuccedInteractive()

    func didEndGame()

}

protocol SceneDelegate: AnyObject {

    func present(scene: SKScene, transition: SKTransition?)

}

// MARK: - Implementation

final class SceneManager: SceneHandler {

    // MARK: - Public types

    public struct Component {
        let logger: Logger
        let audioPlayer: AudioPlayer
        let audioProvider: AudioProvider
        let sceneProvider: SceneProvider
        let colorProvider: ColorProvider
        let delaysProvider: DelaysProvider
    }

    // MARK: - Private types

    private enum Scene {
        case intro
        case presentation
        case room
        case interactive
        case outroFail
        case outroSuccess
    }

    // MARK: - Properties

    weak var sceneDelegate: SceneDelegate!
    var component: Component!

    // MARK: - Private properties

    private var currentScene: Scene = .intro {
        didSet {
            handleSceneChange()
        }
    }

    // MARK: - Public init

    public init() { }

    // MARK: - Methods

    func start() {
        component.audioPlayer.playMusic(file: component.audioProvider.background,
                                        volume: 1,
                                        fadeDuration: component.delaysProvider.introFadeIn)
        handleSceneChange()
    }

    func didEndIntro() {
        component.logger.log(info: "Did end Intro")
        currentScene = .presentation
    }

    func didEndPresentation() {
        component.logger.log(info: "Did end presentation")
        currentScene = .room
    }

    func didEndRoom() {
        component.logger.log(info: "Did end room")
        currentScene = .interactive
    }

    func didFailInteractive() {
        component.logger.log(info: "Did end interactive")
        currentScene = .outroFail
    }

    func didSuccedInteractive() {
        component.logger.log(info: "Did end interactive")
        currentScene = .outroSuccess
    }

    func didPressFailOutroAcceptButton() {
        component.logger.log(info: "Did press fail outro accept button")
        currentScene = .interactive
    }

    func didPressFailOutroRefuseButton() {
        component.logger.log(info: "Did press fail outro refuse button")
        currentScene = .outroSuccess
    }

    func didEndGame() {
        component.logger.log(info: "Did end game. Restarting.")
        currentScene = .intro
    }

    // MARK: - Private methods

    private func handleSceneChange() {
        component.logger.log(info: "Handling scene <\(currentScene)>")

        switch currentScene {
        case .intro:
            let scene = component.sceneProvider.makeIntroScene()
            scene.eventsHandler = self
            sceneDelegate.present(scene: scene, transition: nil)

        case .presentation:
            let transition = SKTransition.fade(with: component.colorProvider.backgroundColor,
                                               duration: component.delaysProvider.presentationFadeIn)
            transition.pausesOutgoingScene = false
            transition.pausesIncomingScene = false
            let scene = component.sceneProvider.makePresentationScene()
            scene.eventsHandler = self
            sceneDelegate.present(scene: scene, transition: transition)

        case .room:
            let scene = component.sceneProvider.makeRoomScene()
            scene.eventsHandler = self
            sceneDelegate.present(scene: scene, transition: nil)

        case .interactive:
            let transition = SKTransition.fade(with: component.colorProvider.backgroundColor,
                                               duration: component.delaysProvider.interactiveFadeIn)
            let scene = component.sceneProvider.makeInteractiveScene()
            scene.eventsHandler = self
            transition.pausesOutgoingScene = false
            transition.pausesIncomingScene = false
            sceneDelegate.present(scene: scene, transition: transition)

        case .outroFail:
            let scene = component.sceneProvider.makeOutroFailScene()
            scene.eventsHandler = self
            sceneDelegate.present(scene: scene, transition: nil)

        case .outroSuccess:
            let transition = SKTransition.fade(with: component.colorProvider.backgroundColor,
                                               duration: component.delaysProvider.outroSuccessFadeIn)
            let scene = component.sceneProvider.makeOutroSuccessScene()
            sceneDelegate.present(scene: scene, transition: transition)
        }
    }

}
