
import SpriteKit
import UIKit

public final class OutroFailScene: SKScene {

    // MARK: - Properties

    weak var eventsHandler: SceneHandler!

    // MARK: - Private properties

    private let logger: Logger
    private let audioPlayer: AudioPlayer
    private let audioProvider: AudioProvider
    private let textProvider: TextProvider
    private let colorProvider: ColorProvider
    private let fontProvider: FontProvider
    private let delaysProvider: DelaysProvider

    // MARK: - Overrides

    init(logger: Logger,
         audioPlayer: AudioPlayer,
         audioProvider: AudioProvider,
         textProvider: TextProvider,
         colorProvider: ColorProvider,
         fontProvider: FontProvider,
         delaysProvider: DelaysProvider) {
        self.logger = logger
        self.audioPlayer = audioPlayer
        self.audioProvider = audioProvider
        self.textProvider = textProvider
        self.colorProvider = colorProvider
        self.fontProvider = fontProvider
        self.delaysProvider = delaysProvider
        super.init(size: .zero)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func didMove(to view: SKView) {
        backgroundColor = colorProvider.backgroundColor
        audioPlayer.playSoundEffect(file: audioProvider.gameOverSound)

        // Nodes
        let titleNode = makeTitleNode(for: view)
        addChild(titleNode)

        let subtitle = makeSubtitleNode(for: view)
        addChild(subtitle)

        let subtitle2 = makeSubtitleNode2(for: view)
        addChild(subtitle2)

        let cameraNode = makeCameraNode(for: view)
        addChild(cameraNode)
        camera = cameraNode

        let acceptButton = makeAcceptButton(for: view)
        addChild(acceptButton)

        let refuseButton = makeRefuseButton(for: view)
        addChild(refuseButton)

        // Actions
        
        let fadeInAction = SKAction.fadeIn(withDuration: delaysProvider.outroFailFadeIn)
        let zoomInAction = SKAction.scale(to: 0.9, duration: delaysProvider.introWaiting)

        run(SKAction.wait(forDuration: delaysProvider.outroFailBlackWaiting)) { [weak self] in
            guard let this = self else { return }
            this.audioPlayer.playMusic(file: this.audioProvider.gameOverTheme, volume: 1, fadeDuration: this.delaysProvider.outroFailFadeIn)
            titleNode.run(fadeInAction)
            acceptButton.run(fadeInAction)
            refuseButton.run(fadeInAction)
            subtitle.run(fadeInAction)
            subtitle2.run(fadeInAction)
            cameraNode.run(zoomInAction)
        }

    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)

            for node in nodes(at: touchLocation) {
                switch node.name {
                case SKLabelNode.acceptButtonName:
                    audioPlayer.playSoundEffect(file: audioProvider.hit)
                    audioPlayer.stopMusic()
                    eventsHandler.didPressFailOutroAcceptButton()

                case SKLabelNode.refuseButtonName:
                    audioPlayer.playSoundEffect(file: audioProvider.hit)
                    audioPlayer.stopMusic()
                    eventsHandler.didPressFailOutroRefuseButton()

                default:
                    break
                }
            }
        }
    }

    // MARK: - Private methods

    private func makeTitleNode(for view: SKView) -> SKLabelNode {
        let titleNode = SKLabelNode(text: textProvider.gameOverTitle)
        titleNode.alpha = 0
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 54
        titleNode.position = .init(x: view.frame.midX, y: 1.5 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeSubtitleNode(for view: SKView) -> SKLabelNode {
        let titleNode = SKLabelNode(text: textProvider.gameOverSubtitle)
        titleNode.alpha = 0
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 24
        titleNode.position = .init(x: view.frame.midX, y: 1.2 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeSubtitleNode2(for view: SKView) -> SKLabelNode {
        let titleNode = SKLabelNode(text: textProvider.gameOverSubtitle2)
        titleNode.alpha = 0
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 24
        titleNode.position = .init(x: view.frame.midX, y: 1.1 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeCameraNode(for view: SKView) -> SKCameraNode {
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        return cameraNode
    }

    private func makeAcceptButton(for view: SKView) -> SKLabelNode {
        let acceptButton = SKLabelNode(text: textProvider.gameOverAcceptButton)
        acceptButton.name = SKLabelNode.acceptButtonName
        acceptButton.alpha = 0
        acceptButton.fontName = fontProvider.mainFont
        acceptButton.fontSize = 30
        acceptButton.position = .init(x: view.frame.midX - 100, y: 0.7 * view.frame.midY)
        acceptButton.horizontalAlignmentMode = .center
        acceptButton.verticalAlignmentMode = .center
        return acceptButton
    }

    private func makeRefuseButton(for view: SKView) -> SKLabelNode {
        let refuseButton = SKLabelNode(text: textProvider.gameOverRefuseButton)
        refuseButton.name = SKLabelNode.refuseButtonName
        refuseButton.alpha = 0
        refuseButton.fontName = fontProvider.mainFont
        refuseButton.fontSize = 30
        refuseButton.position = .init(x: view.frame.midX + 100, y: 0.7 * view.frame.midY)
        refuseButton.horizontalAlignmentMode = .center
        refuseButton.verticalAlignmentMode = .center
        return refuseButton
    }

}


fileprivate extension SKLabelNode {

    static var acceptButtonName: String {
        return "acceptButtonName"
    }

    static var refuseButtonName: String {
        return "refuseButtonName"
    }

}
