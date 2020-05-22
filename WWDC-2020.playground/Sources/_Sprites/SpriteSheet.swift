
import SpriteKit

class SpriteSheet {

    // MARK: - Properties

    let texture: SKTexture
    let rows: Int
    let columns: Int

    var margin: CGFloat
    var spacing: CGFloat

    var frameSize: CGSize {
        let fullWidth = self.texture.size().width
        let fullHeight = self.texture.size().height
        let numberOfColumns = CGFloat(self.columns)
        let numberOfRows = CGFloat(self.rows)
        let frameWidth = (fullWidth - (2 * self.margin + self.spacing * numberOfColumns - 1)) / numberOfColumns
        let frameHeight = (fullHeight - (2 * self.margin + self.spacing * numberOfRows - 1)) / numberOfRows
        return CGSize(width: frameWidth, height: frameHeight)
    }

    // MARK: - Init

    convenience init(texture: SKTexture, rows: Int, columns: Int) {
        self.init(texture: texture, rows: rows, columns: columns, spacing: .zero, margin: .zero)
    }

    init(texture: SKTexture, rows: Int, columns: Int, spacing: CGFloat = .zero, margin: CGFloat = .zero) {
        self.texture = texture
        self.rows = rows
        self.columns = columns
        self.spacing = spacing
        self.margin = margin
    }

    // MARK: - Methods

    func texture(column: Int, row: Int) -> SKTexture? {
        guard (0...self.rows ~= row && 0...self.columns ~= column) else {
            return nil
        }
        let x = self.margin + CGFloat(column) * (self.frameSize.width + self.spacing) - self.spacing
        let y = self.margin + CGFloat(row) * (self.frameSize.height + self.spacing) - self.spacing

        var textureRect = CGRect(x: x,
                                 y: y,
                                 width: self.frameSize.width,
                                 height: self.frameSize.height)

        textureRect = CGRect(x: textureRect.origin.x / self.texture.size().width,
                             y: textureRect.origin.y / self.texture.size().height,
                             width: textureRect.size.width/self.texture.size().width,
                             height: textureRect.size.height/self.texture.size().height)
        return SKTexture(rect: textureRect, in: self.texture)
    }

}
