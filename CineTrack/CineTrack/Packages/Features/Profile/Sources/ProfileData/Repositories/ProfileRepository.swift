import SharedAuth
import Foundation
import ProfileDomain
import SharedStorage

public final class ProfileRepository: ProfileRepositoryProtocol, @unchecked Sendable {

    // MARK: - Dependencies

    private let firestore: RemoteDocumentStore

    private let accountSession: AccountSession
    private let photoProcessor: ProfilePhotoProcessorProtocol

    // MARK: - Initialization

    public init(
        firestore: RemoteDocumentStore,
        accountSession: AccountSession,
        photoProcessor: ProfilePhotoProcessorProtocol
    ) {
        self.firestore = firestore
        self.accountSession = accountSession
        self.photoProcessor = photoProcessor
    }

    // MARK: - Account

    public func fetchAccount() async throws -> ProfileAccount {
        guard let user = accountSession.currentAccount else { throw FirestoreError.unauthenticated }
        let photo = try await firestore.get(
            ProfilePhotoDTO.self,
            collection: "users/\(user.id)/profile",
            documentID: "photo"
        )
        return ProfileAccount(
            email: user.email ?? "",
            createdAt: user.createdAt,
            photoURL: user.photoURL,
            photoData: photo?.data
        )
    }

    public func updatePhoto(_ data: Data) async throws -> Data {
        guard let user = accountSession.currentAccount else { throw FirestoreError.unauthenticated }
        let preparedData = try photoProcessor.prepare(data)
        try Task.checkCancellation()

        try await firestore.set(
            ProfilePhotoDTO(data: preparedData),
            collection: "users/\(user.id)/profile",
            documentID: "photo"
        )

        return preparedData
    }

    public func signOut() async throws {
        try accountSession.signOut()
    }
}
