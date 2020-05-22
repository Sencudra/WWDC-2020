
import SpriteKit
import UIKit

public final class InteractiveScene: SKScene, SKPhysicsContactDelegate {

    // MARK: - Private types

    private enum Constant {

        static var magicScoreNumber: Int {
            return -1
        }

    }

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

    private var score = 15 {
        didSet {
            if score == Constant.magicScoreNumber {
                let block = { [weak self] in
                    guard let this = self, let view = this.view else {
                        return
                    }

                    if this.leftMessage != nil {
                        this.leftMessage!.removeFromParent()
                        this.leftMessage = nil
                    }

                    let moveUp = SKAction.move(by: CGVector(dx: 0.0, dy: 50), duration: 5)
                    let fadeOut = SKAction.fadeOut(withDuration: 1)
                    let message = this.makeLeftMessage(for: view, with: this.textProvider.interactiveMagicScoreTitle)
                    this.leftMessage = message
                    this.addChild(message)

                    message.run(moveUp)
                    message.run(.sequence([.wait(forDuration: 4), fadeOut]), completion: {
                        message.removeFromParent()
                        this.leftMessage = nil
                    })
                }
                run(SKAction.run(block))
            }
        }
    }
    
    private var scoreTitle: SKLabelNode?

    private var leftMessage: SKLabelNode?
    private var rightMessage: SKLabelNode?

    // MARK: - Overrides

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

    public override func didMove(to view: SKView) {
        audioPlayer.playMusic(file: audioProvider.fightTheme, volume: 1, fadeDuration: 1)
        backgroundColor = colorProvider.backgroundColor
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero

        // Nodes
        let field = makeGravityField(for: view)
        addChild(field)

        let me = makeCharacterNode(for: view)
        addChild(me)

        let title = makeTitleNode(for: view)
        title.run(.scale(by: 1.1, duration: 8))
        title.run(.sequence([.wait(forDuration: 3), .fadeOut(withDuration: 5)]))
        addChild(title)

        scoreTitle = makeSubtitleNode(for: view)
        addChild(scoreTitle!)

        // Actions
        let randomMessageAction = { [weak self] in
            guard let this = self, let view = this.view else {
                return
            }

            let isRight = Bool.random()
            let moveUp = SKAction.move(by: CGVector(dx: 0.0, dy: 50), duration: 5)
            let fadeOut = SKAction.fadeOut(withDuration: 1)
            let sequence = SKAction.sequence([.wait(forDuration: 4), fadeOut])

            let message: SKLabelNode
            if isRight && this.rightMessage == nil {
                message = this.makeRightMessage(for: view, with: this.textProvider.interactiveRandom)
                this.rightMessage = message
                this.addChild(message)
                message.run(moveUp)
                message.run(sequence, completion: {
                    message.removeFromParent()
                    this.rightMessage = nil
                })
            } else if this.leftMessage == nil {
                let message = this.makeLeftMessage(for: view, with: this.textProvider.interactiveRandom)
                this.leftMessage = message
                this.addChild(message)
                message.run(moveUp)
                message.run(sequence, completion: {
                    message.removeFromParent()
                    this.leftMessage = nil
                })
            }
        }

        let addEyeBlock = { [weak self] in
            guard let this = self else {
                return
            }

            let eye = this.makeEyeNode(for: view)
            this.addChild(eye)
        }

        run(.repeatForever(.sequence([.wait(forDuration: Double.random(in: 3...5)), .run(randomMessageAction)])))
        run(.repeatForever(.sequence([.run(addEyeBlock), .wait(forDuration: 1.0)])))
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)

            for node in nodes(at: touchLocation) {
                if (node.name == SKSpriteNode.movableName) && node.physicsBody != nil {
                    node.run(SKAction.sequence([
                        SKAction.run({ node.physicsBody = nil }),
                        animationProvider.eyeBlowAnimation
                    ]), completion: { node.removeFromParent() })

                    audioPlayer.playSoundEffect(file: audioProvider.hit)
                    score -= 1
                    scoreTitle?.text = makeTextForScore()
                }
            }
        }
    }

    // MARK: - Public methods

    public func didBegin(_ contact: SKPhysicsContact) {

        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if ((firstBody.categoryBitMask & PhysicsCategory.character.rawValue != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.eye.rawValue != 0)) {
            collisionDetected()
        }
    }

    private func collisionDetected() {
        logger.log(info: "Collistion detected. Game over!")

        eventsHandler.didFailInteractive()
    }

    // MARK: - Private methods

    private func makeTitleNode(for view: SKView) -> SKLabelNode {
        let titleNode = SKLabelNode(text: textProvider.interactiveTitle)
        titleNode.alpha = 1
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 30
        titleNode.position = .init(x: view.frame.midX, y: 1.8 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeSubtitleNode(for view: SKView) -> SKLabelNode {
        let titleNode = SKLabelNode(text: makeTextForScore())
        titleNode.alpha = 0.5
        titleNode.zPosition = 1
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 30
        titleNode.position = .init(x: view.frame.midX, y: 1.6 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeLeftMessage(for view: SKView, with text: String) -> SKLabelNode {
       let titleNode = SKLabelNode(text: text)
       titleNode.alpha = 1
       titleNode.zPosition = 2
       titleNode.fontName = fontProvider.mainFont
       titleNode.fontSize = 20
       titleNode.position = .init(x: view.frame.midX - 20, y: 1.2 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .right
       titleNode.verticalAlignmentMode = .center
       return titleNode
    }

    private func makeRightMessage(for view: SKView, with text: String) -> SKLabelNode {
        let titleNode = SKLabelNode(text: text)
        titleNode.alpha = 1
        titleNode.zPosition = 2
        titleNode.fontName = fontProvider.mainFont
        titleNode.fontSize = 20
        titleNode.position = .init(x: view.frame.midX + 20, y: 1.2 * view.frame.midY)
        titleNode.horizontalAlignmentMode = .left
        titleNode.verticalAlignmentMode = .center
        return titleNode
    }

    private func makeCharacterNode(for view: SKView) -> SKSpriteNode {
        let shadow = SKSpriteNode(texture: textureProvider.playerHandUpShadow)

        let firstFrame = textureProvider.playerHandUpFrames.first!
        let character = SKSpriteNode(texture: firstFrame)

        // Positioning and animation
        shadow.position = CGPoint(x: view.frame.midX, y: view.frame.midY - 100)
        shadow.zPosition = 200
        shadow.setScale(0.5)
        shadow.addChild(character)

        character.position = CGPoint(x: -15.0, y: character.frame.height / 2 - 10)
        character.run(.repeatForever(animationProvider.playerHandUpAnimation))
        character.zPosition = 201

        // Physics
        character.physicsBody = SKPhysicsBody(rectangleOf: character.size)
        character.physicsBody?.isDynamic = false
        character.physicsBody?.categoryBitMask = PhysicsCategory.character.rawValue
        character.physicsBody?.contactTestBitMask = PhysicsCategory.eye.rawValue
        character.physicsBody?.collisionBitMask = PhysicsCategory.none.rawValue
        return shadow
    }

    private func makeEyeNode(for view: SKView) -> SKSpriteNode {
        let firstFrame = textureProvider.eyeFrames.first!
        let eye = SKSpriteNode(texture: firstFrame)
        eye.position = randomPointOnCircle(for: view)
        eye.name = SKSpriteNode.movableName
        eye.zPosition = 202
        eye.setScale(0.5)

        eye.run(.repeatForever(.rotate(byAngle: -CGFloat.pi * 2, duration: 4)))
        eye.run(.repeatForever(animationProvider.eyeRoundAnimation))

        // Physics
        let physicsBody = SKPhysicsBody(circleOfRadius: eye.size.width / 2)
        physicsBody.categoryBitMask = PhysicsCategory.eye.rawValue
        physicsBody.contactTestBitMask = PhysicsCategory.character.rawValue
        physicsBody.collisionBitMask = PhysicsCategory.eye.rawValue
        physicsBody.usesPreciseCollisionDetection = true
        eye.physicsBody = physicsBody
        return eye
    }

    private func makeGravityField(for view: SKView) -> SKFieldNode {
        let field = SKFieldNode.radialGravityField()
        field.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        field.isEnabled = true
        field.categoryBitMask = PhysicsCategory.eye.rawValue
        return field
    }

    // Helpers

    func randomPointOnCircle(for view: SKView) -> CGPoint {
        let radius = sqrt(pow(view.frame.width, 2) + pow(view.frame.height, 2)) / 2 + 50
        let theta = randomAngle()
        let x = radius * cos(theta)
        let y = radius * sin(theta)
        return CGPoint(x: CGFloat(x) + view.frame.midX, y: CGFloat(y) + view.frame.midY)
    }

    func randomAngle() -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32.max)) / CGFloat(UInt32.max - 1) * CGFloat.pi * 2.0
    }

    private func makeTextForScore() -> String {
        return "\(textProvider.interactiveScoreTitle)\(score)"
    }

}

extension SKSpriteNode {

    static var movableName: String {
        return "movable"
    }

}
