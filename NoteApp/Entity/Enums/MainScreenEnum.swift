import Foundation

struct MainScreenEnum {
    struct Cell {
        struct Constr {
            static let topBigConstr: CGFloat = 12
            static let topConstr: CGFloat = 6
            static let bttnLeadingConstr: CGFloat = 20
            static let bttnWidthConstr: CGFloat = 24
            static let titleLeadingConstr: CGFloat = 8
            static let titleTrailingConstr: CGFloat = -20
            static let bttnTopConstr: CGFloat = 12
            static let dateBottomConstr: CGFloat = -12
        }
        
        struct Icon {
            static let pressedBttn = "checkmark.fill"
            static let defaultBttn = "checkmark"
        }
    }
    
    struct View {
        struct String {
            static let placeholder = "Search"
        }
        
        struct Constr {
            static let titleTopConstr: CGFloat = 16
            static let titleLeadingConstr: CGFloat = 20
            static let searchLeadingConstr: CGFloat = 20 - 8
            static let searchTrailingConstr: CGFloat = -20 + 8
            static let spacingConstr: CGFloat = 0
            static let footerHeightConstr: CGFloat = 83
            static let countTopConstr: CGFloat = 20
            static let bttnTrailingConstr: CGFloat = -20
            static let bttnWidthConstr: CGFloat = 28   
        }
    }
}
