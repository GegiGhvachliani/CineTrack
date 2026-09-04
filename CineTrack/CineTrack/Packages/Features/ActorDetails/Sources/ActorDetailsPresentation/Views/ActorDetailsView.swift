//
//  ActorDetailsView.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import SharedCore

public struct ActorDetailsView: View {

    private let actor: Actor

    public init(actor: Actor) {
        self.actor = actor
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(.secondary)

            Text(actor.name)
                .font(.title.bold())

            Text("Actor Details")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Actor")
        .navigationBarTitleDisplayMode(.inline)
    }
}
