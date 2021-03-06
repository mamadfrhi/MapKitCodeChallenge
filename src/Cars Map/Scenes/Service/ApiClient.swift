//
//  APIClient.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import Foundation
import UIKit

protocol Network {
    func fetch(completionHandler: @escaping (Result<Any?, Error>) -> ())
}

struct ApiClient: Network {
    private let configuration: URLSessionConfiguration
    
    init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
    
    func fetch(completionHandler: @escaping (Result<Any?, Error>) -> ()) {
        
        if !connected() { completionHandler(.failure(CarsAPIError.disconnected)) }
        
        
        let url = URL(string: "https://cdn.sixt.io/" + "codingtask/" + "cars")!
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            let clientError = (400...499).contains(httpResponse.statusCode)
            let serverError = (500...599).contains(httpResponse.statusCode)
            
            if let error = error {
                completionHandler(.failure(error))
            } else if clientError {
                completionHandler(.failure(CarsAPIError.clientError))
            } else if serverError {
                completionHandler(.failure(CarsAPIError.serverError))
            } else if let data = data {
                let cat = try? JSONDecoder().decode([Car].self, from: data)
                completionHandler(.success(cat))
            }
        })
        task.resume()
    }
    
    private func connected() -> Bool { // to the internet
        InternetConnectionManager.shared.isConnectedToNetwork()
    }
}

struct CarsAPIError: Error {
    static let noData = NSError(domain: "Server response is not valid.", code: 01, userInfo: nil)
    static let clientError = NSError(domain: "A HTTPS client error occured.", code: 02, userInfo: nil)
    static let serverError = NSError(domain: "A HTTPS server error occured.", code: 03, userInfo: nil)
    static let disconnected = NSError(domain: " You're not connected to the internet. So, you can't add a new cat.\n Whatever you see are offline.", code: 04, userInfo: nil)
}


// MARK: UIImageView Image Download Extension
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data){
                DispatchQueue.main.async() {
                    self.image = image
                }
            }
            else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "car")
                }
            }
            
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
