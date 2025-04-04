import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

final class ColorExtension {
    static let accentWhite = UIColor(hex: 0xF4F4F4)
    static let accentLightWhite = accentWhite.withAlphaComponent(0.5)
    static let accentYellow = UIColor(hex: 0xFED702)
    static let accentGray = UIColor(hex: 0x272729)
    static let accentLightGray = UIColor(hex: 0x4D555E)
}

