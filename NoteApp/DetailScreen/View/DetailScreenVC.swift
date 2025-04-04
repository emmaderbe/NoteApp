import UIKit

final class DetailScreenViewController: UIViewController {
    
    private let detailView = DetailScreenView()
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension DetailScreenViewController {
    func setupView() {
    }
}
