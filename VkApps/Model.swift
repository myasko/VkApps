//
//  Model.swift
//  VkApps
//
//  Created by Георгий Бутров on 13.07.2022.
//

import Foundation

struct Service: Codable {
    let name: String?
    let description: String?
    let link: String?
    let icon_url: String?
}

struct Services: Codable {
    let services: [Service]?
}

struct Response: Codable {
    let body: Services?
}



