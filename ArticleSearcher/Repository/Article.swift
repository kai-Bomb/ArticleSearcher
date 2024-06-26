
import Foundation

struct Article: Identifiable, Decodable {
    let id: String
    let title: String
    let url: String
    let user: User
}

struct User: Decodable {
    let name: String
    let profileImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageURL = "profile_image_url"
    }
}
