import UIKit

final class ButtonFactory {
    static func createStatusButton() -> UIButton {
        let button = UIButton()
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func createFloatingActionButton() -> UIButton {
        let button = UIButton()
        button.tintColor = .black
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 14
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

