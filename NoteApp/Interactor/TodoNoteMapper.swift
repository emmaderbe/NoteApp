import UIKit

protocol TodoToNoteViewModelMapperProtocol {
    func map(_ todos: [TodoNetworkModel]) -> [NoteEntity]
}

final class TodoToNoteViewModelMapper: TodoToNoteViewModelMapperProtocol {
    private let dateFormatter: DateFormatterServiceProtocol
    
    init(dateFormatter: DateFormatterServiceProtocol) {
        self.dateFormatter = dateFormatter
    }
    
    func map(_ todos: [TodoNetworkModel]) -> [NoteEntity] {
        return todos.map { todo in
            let date = Date()
            return NoteEntity(
                title: todo.title,
                description: "Заметка импортирована из API",
                creationDate: dateFormatter.format(date: date),
                isCompleted: todo.isCompleted
            )
        }
    }
}
