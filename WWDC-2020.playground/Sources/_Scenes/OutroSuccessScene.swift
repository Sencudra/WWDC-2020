
import SpriteKit
import UIKit

public final class OutroSuccessScene: SKScene {

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
        audioPlayer.playMusic(file: audioProvider.outroMainTheme, volume: 1, fadeDuration: 2)

        // Nodes
        let titleNode = makeTitleNode(for: view)
        addChild(titleNode)

        let subtitle = makeSubtitleNode(for: view)
        addChild(subtitle)

        let credits = makeCreditsNode(for: view)
        addChild(credits)

        // Actions
        let movingUpShort = SKAction.move(by: CGVector(dx: 0, dy: 300), duration: 10)
        movingUpShort.timingMode = .easeIn

        let movingUpLong = SKAction.move(by: CGVector(dx: 0, dy: 6500), duration: 100)
        movingUpShort.timingMode = .easeIn
        let sequenceAction = SKAction.sequence([movingUpShort, movingUpLong])

        titleNode.run(sequenceAction)
        subtitle.run(sequenceAction)
        credits.run(sequenceAction)
    }

    // MARK: - Private methods

    private func makeTitleNode(for view: SKView) -> SKLabelNode {
        let titleNode = SKLabelNode(text: textProvider.outroTitle)
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 54
        titleNode.position = .init(x: view.frame.midX, y: 1.7 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeSubtitleNode(for view: SKView) -> SKLabelNode {
        var titleNode = SKLabelNode(text: textProvider.outroSubtitle)
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 24
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        titleNode = titleNode.splitLines()
        titleNode.position = .init(x: view.frame.midX, y: 1 * view.frame.midY)
        return titleNode
    }

    private func makeCreditsNode(for view: SKView) -> SKLabelNode {
        var titleNode = SKLabelNode(text: textProvider.outroCredits)
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 24
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .top
        titleNode = titleNode.splitLines()
        titleNode.position = .init(x: view.frame.midX, y: -2950)
        return titleNode
    }

}
