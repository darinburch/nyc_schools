
import Foundation

class SchoolDataService {
    
    static func loadSchoolData(limit: Int, page: Int, orderBy: SchoolOrder) async throws -> [SchoolDTO] {
        guard let url = URL(string: Ref.NYC_SCHOOLS_ENDPOINT(limit: limit, page: page, orderBy: orderBy)) else {
            throw ResponseError.urlBuildError("Url build error")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let httpResponse = response as? HTTPURLResponse
        if !(200...299).contains(httpResponse!.statusCode) {
            do {
                let errorResponse = try JSONDecoder().decode(ErrorMessage.self, from: data)
                throw ResponseError.badRequest("\(errorResponse)")
            } catch {
                throw ResponseError.decodingError(error.localizedDescription)
            }
        }
        
        do {
            let schools = try JSONDecoder().decode([SchoolDTO].self, from: data)
            return schools
            
        } catch {
            throw ResponseError.decodingError(error.localizedDescription)
        }
    }
    
}

