//
//  NetworkManager.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/28.
//

import Foundation

final class NetworkManager {
    typealias NetworkCompletion = (Result<[Item], NetworkError>) -> Void
    
    func fetchYoutubeData(completion: @escaping NetworkCompletion) {
        let urlString = "\(YouTubeAPI.requestURL)\(Secret.youtubeAppKey)"
        performRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            print("\(safeData.description)입니다")
            if let youtubeData = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(youtubeData))
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ youtubeData: Data) -> [Item]? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let youtubeData = try decoder.decode(YoutubeModelAPI.self, from: youtubeData)
            return youtubeData.items
        } catch {
            print("ERROR!")
            print(error.localizedDescription)
            print(error.localizedDescription.description)
            print(String(describing: error))
            return nil
        }
    }
}

