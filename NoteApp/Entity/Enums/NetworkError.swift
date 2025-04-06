import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case clientError
    case serverError
    case unknown
}
