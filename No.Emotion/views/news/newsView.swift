//
//  newsView.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import SwiftUI

struct newsView: View {
    
    @ObservedObject var logic: Logic = LogicAPI
    
    var body: some View {
        VStack(spacing: 20){
            
            ForEach(self.logic.news, id:\.self){ news in
                ZStack{
                    
                    URLImage(URL(string: news.image)!) { proxy in
                        proxy.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200.0)
                            .blur(radius: 5, opaque: true)
                            .cornerRadius(8)
                    }
                    
                    VStack{
                        Text("\(news.title)")
                            .font(Font.custom("Spectral-Medium", size: 18))
                            .padding()
                        
                        Text("― \(news.author)")
                            .font(.custom("SourceCodePro-Regular", size: 14))
                            .foregroundColor(Color.white.opacity(0.7))
                            .padding(.horizontal)
                        
                    }
                }
            }
        }
    }
}

