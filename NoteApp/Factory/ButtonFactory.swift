import UIKit

struct ButtonFactory {
    static func createStatusButton() -> UIButton {
        let button = UIButton()
        button.tintColor = ColorExtension.accentWhite
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func createFloatingActionButton() -> UIButton {
        let button = UIButton()
        button.tintColor = ColorExtension.accentYellow
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

