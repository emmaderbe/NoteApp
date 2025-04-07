import Foundation

protocol NetworkServiceProtocol {
    func fetchTodos(completion: @escaping (Result<[TodoNetworkModel], NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private let urlSession = URLSession.shared
    private let baseURL = "https://dummyjson.com/todos"
    
    func fetchTodos(completion: @escaping (Result<[TodoNetworkModel], NetworkError>) -> Void) {
        guard let url = URL(string: baseURL) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.noData))
                    }
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(TodoResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decoded.todos))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
                
            case 400...499:
                DispatchQueue.main.async {
                    completion(.failure(.clientError))
                }
            case 500...599:
                DispatchQueue.main.async {
                    completion(.failure(.serverError))
                }
            default:
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
            }
        }
        task.resume()
    }
}
