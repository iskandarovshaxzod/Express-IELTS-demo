//
//  APIManager.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 04.02.2023.
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func performRequest<T: Codable, U: Codable>(url: URL, method: HTTPMethod, body: T?,
         parameters: [String: Any]?, completion: @escaping (Result<U, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        if let parameters = parameters {
//            let queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
//            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
//            urlComponents?.queryItems = queryItems
//            request.url = urlComponents?.url
//        }
        
        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo:
                           [NSLocalizedDescriptionKey: "Data was not retrieved from the response."])))
                return
            }
            
            do {
                let decoded: U
                if U.self == [U].self {
                    decoded = try JSONDecoder().decode([U].self, from: data) as! U
                } else {
                    decoded = try JSONDecoder().decode(U.self, from: data)
                }
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func performRequestWithHTTPResponse<T: Codable>(url: URL, method: HTTPMethod, body: T?,
         parameters: [String: Any]?, completion: @escaping (Result<HTTPURLResponse, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        if let parameters = parameters {
//            let queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
//            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
//            urlComponents?.queryItems = queryItems
//            request.url = urlComponents?.url
//        }
        
        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "", code: 0, userInfo:
                           [NSLocalizedDescriptionKey: "Status code was not in 200...299"])))
                return
            }
            
            completion(.success(httpResponse))
            
        }.resume()
    }
    
}

