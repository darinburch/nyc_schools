import Foundation

enum ResponseError: Error {
    case decodingError(String)
    case networkError(String)
    case urlBuildError(String)
    case badRequest(String)
    
    func associatedValue() -> String {
        switch self {
        case .decodingError(let value):
            return value
        case .networkError(let value):
            return value
        case .urlBuildError(let value):
            return value
        case .badRequest(let value):
            return value
        }
    }
}


struct ErrorMessage: Decodable, Error {
    var message: String
}
