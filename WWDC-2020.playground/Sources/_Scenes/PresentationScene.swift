
import SpriteKit
import UIKit

public final class PresentationScene: SKScene {

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
        
        let defaultZoom = SKAction.scale(to: 0.9, duration: delaysProvider.presentationWaiting)
        let fastZoom = SKAction.scale(to: 0.01, duration: 0.5)
        fastZoom.timingMode = .easeIn
        let zoomInAction = SKAction.sequence([defaultZoom, fastZoom])

        let titleNode = makeTitleNode(for: view)
        addChild(titleNode)

        let cameraNode = makeCameraNode(for: view)
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.run(zoomInAction) { [weak self] in
            guard let this = self else { return }
            this.eventsHandler.didEndPresentation()
        }
    }

    // MARK: - Private properties

    private func makeTitleNode(for view: SKView) -> SKLabelNode {
        var titleNode = SKLabelNode(text: textProvider.presentation)
        titleNode.alpha = 1
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 26
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        titleNode = titleNode.splitLines()
        titleNode.position = .init(x: view.frame.midX, y: view.frame.midY)
        return titleNode
    }

    private func makeCameraNode(for view: SKView) -> SKCameraNode {
       let cameraNode = SKCameraNode()
       cameraNode.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
       return cameraNode
   }

}
