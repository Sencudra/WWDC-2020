
import SpriteKit
import UIKit

public final class RoomScene: SKScene {

    // MARK: - Properties

    weak var eventsHandler: SceneHandler!

    // MARK: - Private properties

    private let logger: Logger
    private let audioPlayer: AudioPlayer
    private let textProvider: TextProvider
    private let colorProvider: ColorProvider
    private let audioProvider: AudioProvider
    private let fontProvider: FontProvider
    private let delaysProvider: DelaysProvider
    private let textureProvider: TextureProvider
    private let animationProvider: AnimationProvider

    private var leftMessage: SKLabelNode?

    // MARK: - Init

    init(logger: Logger,
         audioPlayer: AudioPlayer,
         textProvider: TextProvider,
         colorProvider: ColorProvider,
         audioProvider: AudioProvider,
         fontProvider: FontProvider,
         delaysProvider: DelaysProvider,
         textureProvider: TextureProvider,
         animationProvider: AnimationProvider) {
        self.logger = logger
        self.audioPlayer = audioPlayer
        self.textProvider = textProvider
        self.colorProvider = colorProvider
        self.audioProvider = audioProvider
        self.fontProvider = fontProvider
        self.delaysProvider = delaysProvider
        self.textureProvider = textureProvider
        self.animationProvider = animationProvider
        super.init(size: .zero)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    public override func didMove(to view: SKView) {
        backgroundColor = colorProvider.backgroundColor

        // Nodes
        let main = makeMainNode(for: view)
        addChild(main)

        let cameraNode = makeCameraNode(for: view)
        addChild(cameraNode)
        camera = cameraNode

        // Actions
        let textScriptBlock = { [weak self] in
            guard let this = self else { return }

            guard let text = this.textProvider.story else {
                this.eventsHandler.didEndRoom()
                return
            }
            let label = this.makeTitleNode(for: view, with: text)
            this.addChild(label)
            label.run(.wait(forDuration: 7)) {
                label.removeFromParent()
            }
        }

        let randomMessageAction = { [weak self] in
            guard let this = self, let view = this.view else {
                return
            }

            let moveUp = SKAction.move(by: CGVector(dx: 0.0, dy: 50), duration: 5)
            let fadeOut = SKAction.fadeOut(withDuration: 1)
            let sequence = SKAction.sequence([.wait(forDuration: 4), fadeOut])

            if this.leftMessage == nil {
                let message = this.makeMessage(for: view, with: this.textProvider.storyMessages)
                this.leftMessage = message
                this.addChild(message)
                message.run(moveUp)
                message.run(sequence, completion: {
                    message.removeFromParent()
                    this.leftMessage = nil
                })
            }
        }

        let zoomInAction = SKAction.scale(to: 1, duration: 0.5)
        zoomInAction.timingMode = .easeOut

        cameraNode.run(zoomInAction)
        run(.repeatForever(.sequence([.wait(forDuration: Double.random(in: 3...5)), .run(randomMessageAction)])))
        run(.repeatForever(.sequence([.run(textScriptBlock), .wait(forDuration: 7)])))
    }

    // MARK: - Private properties

    private func makeTitleNode(for view: SKView, with text: String) -> SKLabelNode {
        var titleNode = SKLabelNode(text: text)
        titleNode.alpha = 1
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 30
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        titleNode = titleNode.splitLines()
        titleNode.position = .init(x: view.frame.midX, y: 0.3 * view.frame.midY)
        return titleNode
    }

    private func makeMainNode(for view: SKView) -> SKSpriteNode {
        let main = SKSpriteNode(texture: textureProvider.roomMain)

        // Positioning and animation
        main.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        main.zPosition = 1

        // Cat :)
        let firstFrame = textureProvider.catFrames.first!
        let cat = SKSpriteNode(texture: firstFrame)
        cat.zPosition = 2
        cat.position = CGPoint(x: 40, y: -20)
        cat.run(.repeatForever(animationProvider.catAnimation))

        main.addChild(cat)
        return main
    }

    private func makeMessage(for view: SKView, with text: String) -> SKLabelNode {
        let titleNode = SKLabelNode(text: text)
        titleNode.alpha = 1
        titleNode.zPosition = 2
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 20
        titleNode.position = .init(x: view.frame.midX - 120, y: 1.2 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .right
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeCameraNode(for view: SKView) -> SKCameraNode {
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        cameraNode.setScale(10)
        return cameraNode
   }

}
