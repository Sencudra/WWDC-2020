
import PlaygroundSupport
import UIKit

// MARK: - The start

public final class Storyteller {

    // MARK: - Private properties

    let sceneManager: SceneManager
    let rootViewController: RootViewController

    // MARK: - Public init

    public init() {
        self.rootViewController = RootViewController()
        self.sceneManager = SceneManager()
    }

    // MARK: - Public methods

    public func start(with story: Story) {
        rootViewController.component = RootViewController.Component(logger: story.logger,
                                                                    config: story.config)

        sceneManager.component = SceneManager.Component(logger: story.logger,
                                                        audioPlayer: story.audioPlayer,
                                                        audioProvider: story.audioProvider,
                                                        sceneProvider: story.sceneProvider,
                                                        colorProvider: story.colorProvider,
                                                        delaysProvider: story.delaysProvider)

        sceneManager.sceneDelegate = rootViewController
        rootViewController.preferredContentSize = story.config.preferredContentSize
        PlaygroundPage.current.liveView = rootViewController
        sceneManager.start()
    }

}
