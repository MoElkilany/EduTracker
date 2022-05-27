//
//  UserModelResponse.swift
//  EduTracker
//
//  Created by Mohamed Elkilany on 17/05/2022.
//

import Foundation
struct UserModelResponse :Codable {
    let isSuccess: Bool?
    let message: String?
    let status: Int?
    let token, tokenType: String?

    enum CodingKeys: String, CodingKey {
        case isSuccess = "IsSuccess"
        case message = "Message"
        case status = "Status"
        case token, tokenType
    }
}



