//
//  TokenManager.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 09.09.2022.
//

import UIKit
import Alamofire

struct TokenManager {
    private let jwt: HTTPHeaders = [.authorization(bearerToken: JWT.tokenForAddress)]
    private let tokenURL = "https://maps-api.apple.com/v1/token"
    
    // MARK: - Token every 1700 seconds
    func generateToken(completion: @escaping (String) -> Void) {
        AF.request(tokenURL, headers: jwt).responseDecodable(of: Token.self) { response in
            guard let data = response.value else { return }
            completion(data.accessToken)
        }
    }
    
    private func parseTokenJSON(_ token: Data) -> TokenModel? {
        do {
            let token = try JSONDecoder().decode(Token.self, from: token)
            
            let accessToken = token.accessToken
            
            let tokenData = TokenModel(accessToken: accessToken)
            return tokenData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
