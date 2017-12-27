//
//  Request.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    var key: String
    var secret: String
    var token: String?
    
    init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }
    
    public func basicRequest() {
        let BEARER = ((key + ":" + secret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials&client_id=\(key)&client_secret=\(secret)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    self.token = (dic["access_token"] as? String)!
                    if let token = self.token {
                        print("Access token: \(token)")
                    }
                }
                catch (let error){
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    public func getUser(by access_token: String, with user: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(user.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)?access_token=\(access_token)")
        let request = URLRequest(url: url! as URL)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                do {
                    if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(response, nil)
                    }
                }
                catch (let error) {
                    print(error)
                }
            }
            completion(nil, error)
        }
        task.resume()
    }
    
    
}
