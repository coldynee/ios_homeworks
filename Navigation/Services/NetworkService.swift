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
    
    static func request2_1(data: Data) -> [UserModel]? {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                var users: [UserModel] = []
                for item in jsonObject {
                    guard let userId = item["userId"] as? Int,
                          let id = item["id"] as? Int,
                          let title = item["title"] as? String,
                          let completed = item["completed"] as? Bool else {
                        continue
                    }
                    
                    let user = UserModel(userId: userId, id: id, title: title, completed: completed)
                    
                    users.append(user)
                }
                return users
            }
        } catch {
            print("failed parse, \(error.localizedDescription)")
        }
        return nil
    }
    
    static func request2_2(completion: @escaping (Album?) -> Void){
        guard let url = Bundle.main.url(forResource: "album", withExtension: "json") else {
            print("file not found")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                print("http error: \(httpResponse.statusCode)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("no data")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let albumResponse = try decoder.decode(AlbumResponse.self, from: data)
                let album = albumResponse.result
                
                print("success")
                completion(album)
            } catch {
                print("decode error \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}
