
import PlaygroundSupport
import UIKit
import SpriteKit

public final class RootViewController: UIViewController {

    // MARK: - Public types

    public struct Component {
        let logger: Logger
        let config: Config
    }

    // MARK: - Public properties

    public var component: Component!

    // MARK: - Overrides

    public override func loadView() {
        super.loadView()

        self.view = SKView()
    }

    public override var prefersStatusBarHidden: Bool {
        return true
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        guard let skView = self.view as? SKView else {
            component.logger.log(error: "Unable to cast self.view to SKView")
            return
        }

        let viewPreferredSize = component.config.preferredContentSize
        skView.frame = CGRect(x: .zero, y: .zero, width: viewPreferredSize.width, height: viewPreferredSize.height)

        skView.showsFPS = component.config.showFPS
        skView.preferredFramesPerSecond = component.config.preferredFPS
        skView.showsNodeCount = component.config.showNodeCount
        skView.ignoresSiblingOrder = true
    }

}

extension RootViewController: SceneDelegate {

    func present(scene: SKScene, transition: SKTransition?) {
        guard let skView = self.view as? SKView else {
            component.logger.log(error: "Unable to cast self.view to SKView")
            return
        }
        component.logger.log(info: "Presenting scene.")
        scene.scaleMode = .resizeFill

        if let transition = transition {
            skView.presentScene(scene, transition: transition)
        } else {
            skView.presentScene(scene)
        }

    }

}
