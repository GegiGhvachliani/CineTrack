//
//  SearchButtonView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import SwiftUI

struct SearchButtonView: View {
    
    public init () {}
    
    var body: some View {
            Button {
                print("navigate to Search")
            } label: {
                ZStack {
                    Color.gray
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundStyle(.cyan)
                            .cornerRadius(7)
                        
                        HStack (alignment: .firstTextBaseline) {
                            Image(systemName: "magnifyingglass")
                            Text("Search for shows, movies, people...")
                                .foregroundStyle(.red)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
            }
        }
    }
}
