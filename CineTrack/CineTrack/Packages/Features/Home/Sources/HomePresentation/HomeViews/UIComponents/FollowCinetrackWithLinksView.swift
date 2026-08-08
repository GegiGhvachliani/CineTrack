//
//  FollowCinetrackWithLinksView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 08/08/2026.
//

import SwiftUI
import HomeDomain
import DesignSystemTokens

struct FollowCinetrackWithLinksView: View {
    var body: some View {
        VStack(spacing: 15) {
            
            header
            
            footer
            
        }
        .padding(.vertical, 15)
        .background(ColorTokens.Background.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    // MARK: header
    
    private var header: some View {
        HStack(spacing: 8) {
            
            Capsule()
                .frame(width: 4, height: 25)
                .foregroundStyle(ColorTokens.Brand.primary)
            
            Text("Follow CineTrack on")
                .font(TypographyTokens.headline)
            
            Spacer()
        }
        .background(ColorTokens.Background.secondary)
        .padding(.horizontal)
    }
    
    // MARK: footer
    
    private var footer: some View {
        HStack(spacing: 20) {
            makeButton(with: "tikTok", for: .tikTok)
            makeButton(with: "instagram", for: .instagram)
            makeButton(with: "x", for: .xxx)
            makeButton(with: "youtube", for: .youtube)
            makeButton(with: "facebook", for: .facebook)
            
            Spacer()
        }
        .background(ColorTokens.Background.secondary)
        .padding(.horizontal)
    }
    
    // MARK: button maker
    
    @ViewBuilder
    private func makeButton(with imageName: String, for website: Websites) -> some View {
        if let url = website.url {
            Link(destination: url) {
                Image(imageName, bundle: .module)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
    
    
}

#Preview {
    FollowCinetrackWithLinksView()
}
