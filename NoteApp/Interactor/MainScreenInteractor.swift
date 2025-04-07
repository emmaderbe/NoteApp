import Foundation

protocol MainScreenInteractorProtocol: AnyObject {
    func fetchTasks(completion: @escaping (Result<[NoteEntity], Error>) -> Void)
    func deleteTask(at index: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

final class MainScreenInteractor {
    private let networkService: NetworkServiceProtocol
    private let mapper: TodoToNoteViewModelMapperProtocol
    
    private var cachedTasks: [NoteEntity] = []
    
    init(
        networkService: NetworkServiceProtocol,
        mapper: TodoToNoteViewModelMapperProtocol
    ) {
        self.networkService = networkService
        self.mapper = mapper
    }
}

// MARK: - MainScreenInteractorProtocol
extension MainScreenInteractor: MainScreenInteractorProtocol {
    
    func fetchTasks(completion: @escaping (Result<[NoteEntity], Error>) -> Void) {
        networkService.fetchTodos { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let todos):
                let mappedNotes = self.mapper.map(todos)
                self.cachedTasks = mappedNotes
                completion(.success(mappedNotes))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteTask(at index: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard cachedTasks.indices.contains(index) else {
            completion(.failure(NSError(domain: "Invalid index", code: 1)))
            return
        }
        cachedTasks.remove(at: index)
        completion(.success(()))
    }
}
