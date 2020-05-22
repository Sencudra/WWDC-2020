import SpriteKit
import UIKit

extension SKLabelNode {

    func splitLines() -> SKLabelNode {
        guard let text = self.text else {
            print("No text found at SKLabelNode to split lines")
            return self
        }
        let lines: [String] = text.components(separatedBy: "\n")
        return lines.enumerated().reduce(into: SKLabelNode()) { result, line in
            let label = SKLabelNode(fontNamed: self.fontName)
            label.fontColor = self.fontColor
            label.fontSize = self.fontSize
            label.horizontalAlignmentMode = self.horizontalAlignmentMode
            label.verticalAlignmentMode = self.verticalAlignmentMode

            label.position = self.position
            let yPos = CGFloat(line.offset - lines.count / 2) * self.fontSize
            label.position = CGPoint(x: 0, y: -yPos)
            label.text = line.element

            result.addChild(label)
        }
    }

}
