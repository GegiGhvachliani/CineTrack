import Foundation
import SharedCore

struct FavouritedActorDTO: Codable, Sendable {
    let id: Int
    let name: String
    let birthday: Date?
    let profilePath: String?

    init(actor: Actor) {
        id = actor.id
        name = actor.name
        birthday = actor.birthday
        profilePath = actor.profilePath
    }

    func toDomain() -> Actor {
        Actor(id: id, name: name, birthday: birthday, profilePath: profilePath)
    }
}
