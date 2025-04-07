import Foundation

struct TodoNetworkModel: Decodable {
    let id: Int
    let title: String
    let isCompleted: Bool
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title = "todo"
        case isCompleted = "completed"
        case userId
    }
}

struct TodoResponse: Decodable {
    let todos: [TodoNetworkModel]
}
