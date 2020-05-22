
import SpriteKit
import UIKit

public final class IntroScene: SKScene {

    // MARK: - Properties

    weak var eventsHandler: SceneHandler!

    // MARK: - Private properties

    private let textProvider: TextProvider
    private let colorProvider: ColorProvider
    private let audioProvider: AudioProvider
    private let fontProvider: FontProvider
    private let delaysProvider: DelaysProvider

    // MARK: - Overrides

    init(textProvider: TextProvider,
         colorProvider: ColorProvider,
         audioProvider: AudioProvider,
         fontProvider: FontProvider,
         delaysProvider: DelaysProvider) {
        self.textProvider = textProvider
        self.colorProvider = colorProvider
        self.audioProvider = audioProvider
        self.fontProvider = fontProvider
        self.delaysProvider = delaysProvider
        super.init(size: .zero)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        backgroundColor = colorProvider.backgroundColor

        let fadeInActionTitle = SKAction.fadeIn(withDuration: delaysProvider.introFadeIn)
        let fadeInActionSubtitle = SKAction.sequence([SKAction.wait(forDuration: 1.0), fadeInActionTitle])

        let zoomInAction = SKAction.scale(to: 0.9, duration: delaysProvider.introWaiting)

        let titleNode = makeTitleNode(for: view)
        addChild(titleNode)
        titleNode.run(fadeInActionTitle)

        let subtitleNode = makeSubtitleNode(for:view)
        addChild(subtitleNode)
        subtitleNode.run(fadeInActionSubtitle) {[weak self] in
            guard let this = self else { return }
            this.eventsHandler.didEndIntro()
        }

        let cameraNode = makeCameraNode(for: view)
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.run(zoomInAction)
    }

    // MARK: - Private properties

    private func makeTitleNode(for view: SKView) -> SKLabelNode {
        let titleNode = SKLabelNode(text: textProvider.introTitle)
        titleNode.alpha = 0
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 54
        titleNode.position = .init(x: view.frame.midX, y: 1.05 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeSubtitleNode(for view: SKView) -> SKLabelNode {
        let titleNode = SKLabelNode(text: textProvider.introSubtitle)
        titleNode.alpha = 0
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 17
        titleNode.position = .init(x: view.frame.midX, y: 0.9 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeCameraNode(for view: SKView) -> SKCameraNode {
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        return cameraNode
    }

}
