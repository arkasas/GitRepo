//https://grokswift.com/decodable-with-alamofire-4/

import Foundation
import Alamofire

extension JSONDecoder {
    
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }

        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(ServiceError.unknowError)
        }

        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}
