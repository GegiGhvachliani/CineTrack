import FirebaseAuth
import Foundation
import ProfileDomain
import SharedStorage

public final class ProfileRepository: ProfileRepositoryProtocol, @unchecked Sendable {

    // MARK: - Dependencies

    private let firestore: RemoteDocumentStore

    public init(firestore: RemoteDocumentStore) {
        self.firestore = firestore
    }

    // MARK: - Account

    public func fetchAccount() async throws -> ProfileAccount {
        guard let user = Auth.auth().currentUser else { throw FirestoreError.unauthenticated }
        let photo = try await firestore.get(
            ProfilePhotoDTO.self,
            collection: "users/\(user.uid)/profile",
            documentID: "photo"
        )
        return ProfileAccount(
            email: user.email ?? "Account",
            createdAt: user.metadata.creationDate,
            photoURL: user.photoURL,
            photoData: photo?.data
        )
    }

    public func updatePhoto(_ data: Data) async throws {
        guard let user = Auth.auth().currentUser else { throw FirestoreError.unauthenticated }
        try await firestore.set(
            ProfilePhotoDTO(data: data),
            collection: "users/\(user.uid)/profile",
            documentID: "photo"
        )
    }

    public func signOut() async throws {
        try Auth.auth().signOut()
    }
}

private struct ProfilePhotoDTO: Codable, Sendable {
    let data: Data
}
