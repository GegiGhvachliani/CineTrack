//
//  NewsCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

struct News: Identifiable {
    let id: UUID = UUID()
    let photoURL: String?
    let artcleAuthor: String
    let articleTitle: String
    let article: String
    let date: String
}

struct NewsCell: View {
    
    let news: News
    let cellHeight: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            
            header
            
            Rectangle()
                .fill(.secondary)
                .frame(height: 1)
            
            footer
        }
        .frame(
            width: cellHeight * 1.5,
            height: cellHeight
        )
        .background(ColorTokens.Background.primary)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    
    private var header: some View {
        
        HStack(spacing: 8) {
            
            PosterImageView(photoURL: news.photoURL)
                .frame(width: 75, height: 105)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading) {
                
                Text(news.artcleAuthor)
                    .font(TypographyTokens.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Text(news.articleTitle)
                    .font(TypographyTokens.bodySmallSmall)
                    .opacity(0.8)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 1)
                
                Spacer()
                
                Text("\(news.date) hours ago")
                    .font(TypographyTokens.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .frame(height: cellHeight / 2)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
    
    
    private var footer: some View {
        
        Text(news.article)
            .font(TypographyTokens.footnote)
            .foregroundStyle(.secondary)
            .lineLimit(4)
            .multilineTextAlignment(.leading)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(8)
    }
}
#Preview {
    let news = News(
        photoURL: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
        artcleAuthor: "BBC News ",
        articleTitle: "მაგალითად, The News API-ს აქვს უფასო გეგმა. კი — შეგვიძლია ზუსტად ამ დიზაინის",
        article: "შენს შემთხვევაში საუკეთესო იქნება News API + TMDB ერთად: TMDB ფილმის მონაცემებისთვის, News API კი  TMDB თავად news-სტატიებს არ გაძლევს.შენს შემთხვევაში საუკეთესო იქნება News API + TMDB ერთად: TMDB ფილმის მონაცემებისთვის, News API კი  TMDB თავად news-სტატიებს არ გაძლევს.",
        date: "3"
    )
    NewsCell(news: news, cellHeight: 220)
}
