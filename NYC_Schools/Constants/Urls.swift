
import Foundation

class Ref {
    static func NYC_SCHOOLS_ENDPOINT(limit: Int, page: Int, orderBy: SchoolOrder) -> String {
        "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$limit=\(limit)&$offset=\(page)&$order=\(orderBy.key())"
    }
    
    static func SAT_ENDPOINT(dbn: String) -> String {
        "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(dbn)"
    }
}
