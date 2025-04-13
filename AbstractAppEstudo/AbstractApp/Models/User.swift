//
//  User.swift
//  AbstractApp
//
//  Created by user272851 on 4/12/25.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var phone: String
    var bio: String
    
    static let storageKey = "user_data"
    
    static func save(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            StoreManager.shared.save(String(data: encoded, encoding: .utf8) ?? "", forKey: storageKey)
        }
    }
    
    static func load() -> User? {
        guard let savedString = StoreManager.shared.get(forKey: storageKey),
              let data = savedString.data(using: .utf8),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil
        }
        return user
    }
}
