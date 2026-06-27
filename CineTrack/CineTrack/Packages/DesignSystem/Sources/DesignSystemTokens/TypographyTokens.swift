//
//  TypographyTokens.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 27/06/2026.
//

import SwiftUI

//💡 სწრაფი რჩევა ორიენტაციისთვის:
//თუ სათაურს წერ: აირჩიე largeTitle (თუ ძალიან დიდია) ან title2/title3 (საშუალო/პატარა კონტენტის სათაურებისთვის).
//
//თუ უბრალო ტექსტს (პარაგრაფს) წერ: ყოველთვის გამოიყენე body ან bodySmall.
//
//თუ ღილაკს აკეთებ: გამოიყენე headline.
//
//თუ პატარა ინფორმაციას წერ (რეიტინგი, წელი, დრო): გამოიყენე caption ან footnote.


public enum Typography {

    /// **ონბორდინგის და მთავარი ეკრანების მთავარი სათაური**
    /// - *გამოყენება:* ონბორდინგის ეკრანების პირველი დიდი ტექსტი (მაგ: "Discover New Movies").
    public static let largeTitle = Font.system(size: 34, weight: .bold)
    
    /// **დიდი სექციების სათაური**
    /// - *გამოყენება:* ფილმის დეტალების გვერდზე ფილმის სახელი, ან ეკრანის ზედა სათაური (Navigation Title), თუ Large Title არ გინდა.
    public static let title1 = Font.system(size: 28, weight: .bold)
    
    /// **საშუალო ზომის სათაური**
    /// - *გამოყენება:* ჰორიზონტალური ფილმების სიის (Carousels) სათაურები (მაგ: "Trending Now", "Top Rated").
    public static let title2 = Font.system(size: 22, weight: .bold)
    
    /// **პატარა სექციების ან ბარათების (Cards) სათაური**
    /// - *გამოყენება:* ფილმის პატარა ბარათზე ფილმის სახელის დასაწერად, ან Preference გვერდზე ჟანრების ბლოკის სათაურად.
    public static let title3 = Font.system(size: 20, weight: .semibold)
    
    /// **მნიშვნელოვანი/გამოკვეთილი ტექსტები და ღილაკები**
    /// - *გამოყენება:* დიდ "Continue" ან "Get Started" ღილაკებში არსებული ტექსტი, ან მომხმარებლის სახელი პროფილში.
    public static let headline = Font.system(size: 17, weight: .semibold)
    
    /// **ძირითადი კითხხვადი ტექსტი (Standard Text)**
    /// - *გამოყენება:* ფილმის აღწერა (Overview/Plot), ონბორდინგის სათაურის ქვედა განმარტებითი ტექსტები. ყველაზე ხშირად გამოყენებადი ფონტია.
    public static let body = Font.system(size: 17, weight: .regular)
    
    /// **შედარებით მცირე ზომის ძირითადი ტექსტი**
    /// - *გამოყენება:* ჟანრების თეგების (Chips) შიგნით არსებული ტექსტისთვის ("Action", "Comedy") ან შედარებით გრძელი და მეორეხარისხოვანი აღწერებისთვის.
    public static let bodySmall = Font.system(size: 15, weight: .regular)
    
    /// **დამხმარე ან მეტა-მონაცემების ტექსტი**
    /// - *გამოყენება:* ფილმის გამოშვების წელი, ხანგრძლივობა, ჟანრი ფილმის ბარათზე (მაგ: "2024 • 2h 10m").
    public static let caption = Font.system(size: 13, weight: .regular)
    
    /// **ყველაზე პატარა, დამატებითი ინფორმაციის ტექსტი**
    /// - *გამოყენება:* IMDb რეიტინგის ციფრი ვარსკვლავის გვერდით (მაგ: "8.5"), მსახიობის როლის სახელი ფილმში, ან Terms & Conditions ლინკი ონბორდინგის ბოლოში.
    public static let footnote = Font.system(size: 12, weight: .regular)
}
