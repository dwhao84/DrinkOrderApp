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
    
    
    // MARK: - Result type:
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
    
    
    // MARK: - POST orders
    func postOrdersData () {
        
    }
    
    
    // MARK: - PATCH orders
    func patchOrdersData () {
        
    }
    
    
    // MARK: - DELETE orders
    func deleteOrdersData () {
        
    }
    
}
