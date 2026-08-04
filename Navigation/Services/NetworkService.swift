//
//  NetworkService.swift
//  Navigation
//
//  Created by Никита Морозов on 04.08.2026.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    case first = "https://jsonplaceholder.typicode.com/users/1"
    case second = "https://jsonplaceholder.typicode.com/users/2"
    case third = "https://jsonplaceholder.typicode.com/users/3"
}

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        guard let url = URL(string: configuration.rawValue) else {
            print("cant unwrap url: \(configuration.rawValue)")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { data, responce, error in
            if let error = error {
                let nserror = error as NSError
                print(error.localizedDescription)
                print("code: \(nserror.code)")
                return
            }
            if let httpresponce = responce as? HTTPURLResponse, httpresponce.statusCode != 200 {
                print("network error: status code - \(httpresponce.statusCode), allHeaderFields - \(httpresponce.allHeaderFields)")
                return
            }
            guard let data else {
                print("no data")
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print("data: \(jsonString)")
            } else {
                print("cant unwrap to string")
            }
        }.resume()
    }
}
