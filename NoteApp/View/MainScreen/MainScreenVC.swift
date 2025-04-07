import UIKit

final class MainScreenViewController: UIViewController {
    private let mainScreenView = MainScreenView()
    private let delegate = NoteTableViewDelegate()
    private let dataSource = NoteTableViewDataSource()

    private var presenter: MainScreenPresenterProtocol!
    
    override func loadView() {
        self.view = mainScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupView()
        setupDelegate()
        setupDataSource()
        presenter.viewDidLoad()
        updateData()
    }
}

// MARK: - Setup
private extension MainScreenViewController {
    func setupPresenter() {
        let networkService = NetworkService()
        let dateFormatter = DateFormatterService()
        let mapper = TodoToNoteViewModelMapper(dateFormatter: dateFormatter)
        let interactor = MainScreenInteractor(networkService: networkService, mapper: mapper)
        presenter = MainScreenPresenter(view: self, interactor: interactor)
    }

    func setupView() {
        mainScreenView.setupTitle(with: "Задачи")
        mainScreenView.onBttnTapped = { [weak self] in
            self?.presenter.didTapAddTask()
        }
    }
    
    func setupDataSource() {
        dataSource.delegate = self
        dataSource.updateTasks(tasksFromPresenter())
        mainScreenView.setDataSource(dataSource)
    }
    
    func setupDelegate() {
        delegate.delegate = self
        delegate.updateTasks(tasksFromPresenter())
        mainScreenView.setDelegate(delegate)
    }
    
    func updateData() {
        mainScreenView.reloadData()
        mainScreenView.updateTaskCount(for: presenter.numberOfTasks())
    }

    func tasksFromPresenter() -> [NoteEntity] {
        (0..<presenter.numberOfTasks()).map { presenter.task(at: $0) }
    }
}

// MARK: - MainScreenViewProtocol

extension MainScreenViewController: MainScreenViewProtocol {
    
    func showTasks() {
        setupDataSource()
        setupDelegate()
        updateData()
    }

    func showEmptyState() {
        dataSource.updateTasks([])
        delegate.updateTasks([])
        updateData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - TableView Delegate & DataSource

extension MainScreenViewController: NoteTableViewDelegateProtocol {
    func didSelectTask(at index: Int) {
        presenter.didSelectTask(at: index)
    }
}

extension MainScreenViewController: NoteTableViewDataSourceProtocol {
    func deleteTask(at index: Int) {
        presenter.didDeleteTask(at: index)
        showTasks()
    }
}
