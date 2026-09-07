import SwiftUI
import ActorDetailsDomain
import DesignSystemTokens

public struct MiniBiographyView: View {
    private let actor: ActorDetails

    public init(actor: ActorDetails) {
        self.actor = actor
    }

    public var body: some View {
        ScrollView {
            Text(actor.biography ?? "No biography is available for \(actor.name).")
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(.white.opacity(0.9))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .background(ColorTokens.Background.secondary)
        .navigationTitle("Mini Biography: \(actor.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
