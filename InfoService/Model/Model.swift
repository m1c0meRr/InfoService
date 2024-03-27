//
//  Model.swift
//  InfoService
//
//  Created by Sergey Savinkov on 27.03.2024.
//

import Foundation

// MARK: - Model
struct Model: Codable {
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let services: [Service]
}

// MARK: - Service
struct Service: Codable {
    let name, description: String
    let link: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case name, description, link
        case iconURL = "icon_url"
    }
}
