import Foundation

public protocol ProfileRepositoryProtocol: Sendable {
    func fetchAccount() async throws -> ProfileAccount
    func updatePhoto(_ data: Data) async throws
    func signOut() async throws
}
