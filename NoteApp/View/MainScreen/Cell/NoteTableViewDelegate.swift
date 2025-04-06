import UIKit

protocol NoteTableViewDelegateProtocol: AnyObject {
    func didSelectTask(at index: Int)
}

final class NoteTableViewDelegate: NSObject, UITableViewDelegate {
    
    private var tasks: [NoteEntity] = []
    weak var delegate: NoteTableViewDelegateProtocol?
    
    func updateTasks(_ tasks: [NoteEntity]) {
        self.tasks = tasks
    }
}

extension NoteTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectTask(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
        }
}
