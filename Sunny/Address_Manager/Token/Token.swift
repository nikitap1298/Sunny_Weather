//
//  Token.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 09.09.2022.
//

import UIKit

struct Token: Decodable {
    let accessToken: String
}

struct TokenModel {
    var accessToken: String = ""
}
