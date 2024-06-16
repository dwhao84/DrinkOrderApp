//
//  NetworkManager.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/15.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    // Set up API Key
    static let apiKey: String = "patxAQx4KLgwEsh8O.28a883dd0c29a3920aee1cc069fc876738b14186ec8ec2dd07cc762b70497e0c"
    
    // GET URL from Airtable's Data.
    static let getApiUrl: String = "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke"
    // POST, PATCH, DELETE from empty Airtable.
    private let apiUrl: String = "https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke%20Order"
    
    // Set up Authorization as a string for authorization.
    static let authorization: String = "Authorization"
    static let contentType: String = "Content-Type"
    static let application_json: String = "application/json"
    
    
    // MARK: - Result type for GET:
    enum Result<drinks, Error: Swift.Error>  {
        case success(drinks)
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
    }
    
    // MARK: - GET orders data
    func getOrdersData(url: String, completion: @escaping( Result<Kebuke, NetworkError>) -> Void) {
        guard let url = URL(string: NetworkManager.getApiUrl) else {
            print("Unable to fetch url")
            completion(.failure(.invalidURL))
            return
        }

        // MARK: - Set up request
        var request = URLRequest(url: url)
        request.setValue("Bearer \(NetworkManager.apiKey)", forHTTPHeaderField: NetworkManager.authorization)
        
        URLSession.shared.dataTask(with: request) {  data, response, error in
            
            // MARK: - error
            if let error = error {
                print("\(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            // MARK: - Chech httpResponse status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                // TODO: - print out response
                print("\(String(describing: response))")
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
            // MARK: - Check able to get data
            guard let data = data else {
                print("No data received")
                completion(.failure(.noDataReceived))
                return
            }
            
            // MARK: - JSONDecoder
            do {
                // TODO:
                let decoder = JSONDecoder()
                let drinksData = try decoder.decode(Kebuke.self, from: data)
                completion(.success(drinksData))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    var orders: [Order] = []
    
    // MARK: - Result type for POST and PATCH:
    enum CreateOrder<Order, Error> {
        case success(Order)
        case failure(Error)
    }
    
//    enum PostNetworkError: Error {
//        case invalidUrl
//        case encodeError
//        case noData
//        case decodeError
//        case custom(String)
//    }
    
    
    // MARK: - POST orders
    func postOrdersData(order: Order, completion: @escaping(Result<Order, NetworkError>) -> Void) {
        guard let url = URL(string: apiUrl) else {
            fatalError()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(NetworkManager.application_json, forHTTPHeaderField: NetworkManager.contentType)
        
        do {
            let jsonData = try JSONEncoder().encode(orders)
            request.httpBody = jsonData
            print(jsonData)
        } catch {
            completion(.failure(.encodeError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Make sure no error.
            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            
            // Make sure have data.
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let createOrder = try JSONDecoder().decode(Order.self, from: data)
                completion(.success(createOrder))
            } catch {
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    
    // MARK: - PATCH orders
    func patchOrdersData (orderId: String, updatedOrder: Order, completion: @escaping (Result<Order, NetworkError>) -> Void) {
        let patchUrl: String = "\(apiUrl)/\(orderId)"
        
        guard let url = URL(string: patchUrl) else {
            fatalError()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(NetworkManager.application_json, forHTTPHeaderField: NetworkManager.contentType)
        
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
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let task = try JSONDecoder().decode(Order.self, from: data)
                completion(.success(updatedOrder))
            } catch {
                completion(.failure(.decodeError))
                return
            }
        }
        task.resume()
    }
    
    
    // MARK: - DELETE orders
    func deleteOrdersData (orderId: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let deleteUrl = "\(apiUrl)/\(orderId)"
        
        guard let url = URL(string: deleteUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(NetworkManager.application_json, forHTTPHeaderField: NetworkManager.contentType)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(.unexpectedStatusCode))
            }
        }
        task.resume()
    }
    
}
