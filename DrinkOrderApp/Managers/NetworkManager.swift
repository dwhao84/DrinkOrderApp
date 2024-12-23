import UIKit

class NetworkManager {
    
    // Set up API Key
    static let shared = NetworkManager()
    private init() {}
    
    static let apiKey = APIConfig.airtableApiKey
    static let getApiUrl = "\(APIConfig.baseUrl)/Kebuke"
    private let apiUrl = "\(APIConfig.baseUrl)/Kebuke%20Order"
    let token = APIConfig.favqsToken
    private let url = APIConfig.favqsUrl
    
    enum API {
        // Set up Authorization as a string for authorization.
        static let authorization: String = "Authorization"
        static let contentType: String = "Content-Type"
        static let application_json: String = "application/json"
    }
    
    enum NetworkError: Swift.Error {
        case invalidURL
        case requestFailed
        case unexpectedStatusCode
        case noDataReceived
        case decodeError
        case custom(String)
        case encodeError
        
        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "The URL is invalid."
            case .encodeError:
                return "Failed to encode the order data."
            case .noDataReceived:
                return "No data received from the server."
            case .decodeError:
                return "Failed to decode the server response."
            case .custom(let message):
                return message
            case .requestFailed:
                return "Request failed."
            case .unexpectedStatusCode:
                return "Unexpected status code."
            }
        }
    }
    
    // MARK: - GET orders data
    func getOrdersData(completion: @escaping (Result<Kebuke, NetworkError>) -> Void) {
        guard let url = URL(string: NetworkManager.getApiUrl) else {
            print("Unable to fetch url")
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(NetworkManager.apiKey, forHTTPHeaderField: API.authorization)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("\(String(describing: response))")
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                // print out jsonString
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                let decoder = JSONDecoder()
                let drinksData = try decoder.decode(Kebuke.self, from: data)
                completion(.success(drinksData))
            } catch {
                print("Decode error: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    // MARK: - GET Orders:
    func getAirtableData(completion: @escaping (Result<[CustomerOrder], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke%20Order?maxRecords=100&view=Grid%20view") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(NetworkManager.apiKey, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle network error
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(.requestFailed))
                }
                return
            }
            
            // Check the response status code
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("Unexpected status code: \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    completion(.failure(.unexpectedStatusCode))
                }
                return
            }
            
            // Ensure data is not nil
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    completion(.failure(.noDataReceived))
                }
                return
            }
            
            do {
                // Debug: Print out JSON response
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                // Decode the JSON data
                let decoder = JSONDecoder()
                let orderResponse = try decoder.decode(OrderResponse.self, from: data)
                
                // Pass the result back on the main thread
                DispatchQueue.main.async {
                    completion(.success(orderResponse.records))
                }
                
            } catch {
                // Handle decoding error
                print("Decode error: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Failed JSON: \(jsonString)")
                }
                DispatchQueue.main.async {
                    completion(.failure(.decodeError))
                }
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    
    func updateOrder(recordID: String, updatedFields: [String: Any], completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke%20Order/\(recordID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer YOUR_API_KEY", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = ["fields": updatedFields]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(.failure(.requestFailed))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(.requestFailed))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected status code")
                DispatchQueue.main.async {
                    completion(.failure(.unexpectedStatusCode))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }.resume()
    }
    
    // MARK: - POST orders
    func postOrdersData(order: Order, completion: @escaping (Result<Order, NetworkError>) -> Void) {
        guard let url = URL(string: apiUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(NetworkManager.apiKey, forHTTPHeaderField: API.authorization)
        request.setValue(API.application_json, forHTTPHeaderField: API.contentType)
        
        do {
            let jsonData = try JSONEncoder().encode(order)
            request.httpBody = jsonData
            // print out json encode
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request JSON: \(jsonString)")
            }
        } catch {
            completion(.failure(.encodeError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                // print out jsonString
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                let createOrder = try JSONDecoder().decode(Order.self, from: data)
                completion(.success(createOrder))
            } catch {
                
                // print out jsonString for checking data's value.
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                print("Decode error: \(error)")
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    // MARK: - PATCH orders
    func patchOrdersData(orderId: String, updatedOrder: Order, completion: @escaping (Result<Order, NetworkError>) -> Void) {
        let patchUrl: String = "\(apiUrl)/\(orderId)"
        
        guard let url = URL(string: patchUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(NetworkManager.apiKey, forHTTPHeaderField: API.authorization)
        request.setValue(API.application_json, forHTTPHeaderField: API.contentType)
        
        do {
            let jsonData = try JSONEncoder().encode(updatedOrder)
            request.httpBody = jsonData
        } catch {
            completion(.failure(.encodeError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let updatedOrder = try JSONDecoder().decode(Order.self, from: data)
                completion(.success(updatedOrder))
            } catch {
                print("Decode error: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    // MARK: - DELETE orders
    func deleteOrdersData(orderId: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let deleteUrl = "\(apiUrl)/\(orderId)"
        
        guard let url = URL(string: deleteUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(NetworkManager.apiKey, forHTTPHeaderField: API.authorization)
        request.setValue(API.application_json, forHTTPHeaderField: API.contentType)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(.unexpectedStatusCode))
            }
        }
        task.resume()
    }
    
    // MARK: - Create User
    static func createUsers (user: [String: String]) {
        let url: URL = URL(string: "https://favqs.com/api/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(API.application_json, forHTTPHeaderField: API.contentType)
        request.setValue("Token token=a7c01d0f0e393ecf59c17dd7a66b193a", forHTTPHeaderField: API.authorization)
        
        let requestBody = ["user": user]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invaild response")
                return
            }
            
            print("Status Code: \(httpResponse.statusCode)")
            
            if let data = data {
                if httpResponse.statusCode == 200 {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response JSON: \(json)")
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("\(json)")
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                }
            }
        }
        task.resume()
    }
}
