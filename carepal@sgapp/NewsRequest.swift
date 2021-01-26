////
////  NewsRequest.swift
////  carepal@sgapp
////
////  Created by Goh Qi Xun on 13/1/21.
////
//
//import Foundation
//
//enum NewsError:Error {
//    case noDataAvailable
//    case unavailableToProcess
//}
//
//struct NewsRequest {
//    let resourceURL:URL
//    let API_KEY = "049b4f64c5ff4c6a9a4cde43c7300cd9"
//    
//    init()
//    {
//        let resourceString = "http://newsapi.org/v2/top-headlines?country=sg&apiKey=\(API_KEY)"
//        guard let resourceURL = URL(string: resourceString) else {fatalError()}
//        
//        self.resourceURL = resourceURL
//    }
//    
//    func getNews (completion: @escaping(Result<[Article], NewsError>) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data,_,_ in
//            guard let jsonData = data else
//            {
//                completion(.failure(.noDataAvailable))
//                return
//            }
//            do
//            {
//                let decoder = JSONDecoder()
//                let newsResponse = try decoder.decode(ArticleResponse.self, from: jsonData)
//                let articleDetails = newsResponse.response.articles
//                completion(.success(articleDetails))
//            }
//            catch
//            {
//                completion(.failure(.unavailableToProcess))
//            }
//        }
//        dataTask.resume()
//    }
//}
