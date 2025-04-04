import UIKit

final class MainScreenViewController: UIViewController {
    private let mainScreenView = MainScreenView()
    private let delegate = NoteTableViewDelegate()
    private let dataSource = NoteTableViewDataSource()
    
    private var tasks: [NoteEntity] = [
        NoteEntity(title: "Почитать книгу", description: "Список продуктов для ужина", creationDate: .now, isCompleted: true),
        NoteEntity(title: "Заняться спортом", description: "Тренировка дома", creationDate: .now, isCompleted: false),
    ]
    
    override func loadView() {
        self.view = mainScreenView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegate()
        setupDataSource()
        updateData()
    }
}

private extension MainScreenViewController {
    func setupView() {
        mainScreenView.setupTitle(with: "Задачи")
        mainScreenView.onBttnTapped = { [weak self] in
            print("Нажата кнопка добавления задачи")
        }
    }
    
    func setupDataSource() {
        dataSource.delegate = self
        dataSource.updateTasks(tasks)
        mainScreenView.setDataSource(dataSource)
    }
    
    func setupDelegate() {
        delegate.delegate = self
        delegate.updateTasks(tasks)
        mainScreenView.setDelegate(delegate)
    }
    
    func updateData() {
        mainScreenView.reloadData()
        mainScreenView.updateTaskCount(for: tasks.count)
    }
}

extension MainScreenViewController: NoteTableViewDelegateProtocol {
    func didSelectTask(at index: Int) {
        print("Выбрана задача: \(tasks[index].title)")
    }
}

extension MainScreenViewController: NoteTableViewDataSourceProtocol {
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
        dataSource.updateTasks(tasks)
        delegate.updateTasks(tasks)
        updateData()
    }
}

