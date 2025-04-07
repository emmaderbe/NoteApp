import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAddTask()
    func didSelectTask(at index: Int)
    func didDeleteTask(at index: Int)
    func numberOfTasks() -> Int
    func task(at index: Int) -> NoteEntity
}

final class MainScreenPresenter {
    private weak var view: MainScreenViewProtocol?
    private let interactor: MainScreenInteractorProtocol
    
    private var tasks: [NoteEntity] = []
    
    init(
        view: MainScreenViewProtocol,
        interactor: MainScreenInteractorProtocol,
    ) {
        self.view = view
        self.interactor = interactor
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    func didTapAddTask() {
        print("didTapAddTask")
    }
    
    
    func viewDidLoad() {
        interactor.fetchTasks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let notes):
                self.tasks = notes
                if notes.isEmpty {
                    self.view?.showEmptyState()
                } else {
                    self.view?.showTasks()
                }
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func didSelectTask(at index: Int) {
        guard tasks.indices.contains(index) else { return }
        let note = tasks[index]
    }
    
    func didDeleteTask(at index: Int) {
        interactor.deleteTask(at: index) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.tasks.remove(at: index)
                if self.tasks.isEmpty {
                    self.view?.showEmptyState()
                } else {
                    self.view?.showTasks()
                }
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func numberOfTasks() -> Int {
        tasks.count
    }
    
    func task(at index: Int) -> NoteEntity {
        tasks[index]
    }
}

