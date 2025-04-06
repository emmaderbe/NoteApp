import Foundation

protocol DateFormatterServiceProtocol {
    func format(date: Date) -> String
}

final class DateFormatterService: DateFormatterServiceProtocol {
    private let formatter: DateFormatter
    
    init() {
        formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
    }
    
    func format(date: Date) -> String {
        return formatter.string(from: date)
    }
}
