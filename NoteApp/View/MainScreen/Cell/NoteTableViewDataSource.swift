import UIKit

protocol NoteTableViewDataSourceProtocol: AnyObject {
    func deleteTask(at index: Int)
}

final class NoteTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var tasks: [NoteEntity] = []
    weak var delegate: NoteTableViewDataSourceProtocol?
    
    func updateTasks(_ tasks: [NoteEntity]) {
        self.tasks = tasks
    }
}

extension NoteTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoteTableViewCell.identifier,
            for: indexPath) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        
        let task = tasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }
}
