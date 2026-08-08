//
//  PosterImageView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI

struct PosterImageView: View {
    
    let photoURL: String?
    
    var body: some View {
        AsyncImage(
            url: URL(string: photoURL ?? "")
        ) { phase in
            
            switch phase {
                
            case .empty:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                    }
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                
            case .failure:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.gray)
                    }
                
            @unknown default:
                EmptyView()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .clipped()
        
    }
}
