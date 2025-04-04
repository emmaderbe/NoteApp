import Foundation

struct NoteEntity {
    var title: String
    var description: String
    var creationDate: Date
    var isCompleted: Bool
}

extension NoteEntity {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: creationDate)
    }
}
