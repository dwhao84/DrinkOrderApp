import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // Set up API Key
    static let apiKey: String = "Bearer patxAQx4KLgwEsh8O.28a883dd0c29a3920aee1cc069fc876738b14186ec8ec2dd07cc762b70497e0c"
    // GET URL from Airtable's Data.
    static let getApiUrl: String = "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke"
    // POST, PATCH, DELETE from empty Airtable.
    private let apiUrl: String = "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke%20Order"
    
    let token: String  = "Token token a7c01d0f0e393ecf59c17dd7a66b193a"
    private let url: String    = "https://favqs.com/api/"

    enum API {
        // Set up Authorization as a string for authorization.
        static let authorization: String = "Authorization"
        static let contentType: String = "Content-Type"
        static let application_json: String = "application/json"
    }
    
    enum Result<T, Error: Swift.Error> {
        case success(T)
        case failure(Error)
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
