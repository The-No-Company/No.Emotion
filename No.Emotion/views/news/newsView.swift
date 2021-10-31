//
//  newsView.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import SwiftUI

struct newsView: View {
    var body: some View {
        VStack(spacing: 20){
            
            ZStack{
                Image("demo_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200.0)
                    .blur(radius: 5, opaque: true)
                    .cornerRadius(8)
                    
                VStack{
                    Text("“Don't be pushed around by the fears in your mind. Be led by the dreams in your heart.”")
                        .font(Font.custom("Spectral-Medium", size: 18))
                        .padding()
                    
                    Text("― Roy T. Bennett, The Light in the Heart")
                        .font(.custom("SourceCodePro-Regular", size: 14))
                        .foregroundColor(Color.white.opacity(0.7))
                        .padding(.horizontal)
                    
                }
            }
            
            ZStack{
                Image("demo_2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200.0)
                    .blur(radius: 5, opaque: true)
                    .cornerRadius(8)
                   
                VStack{
                    Text("“Instead of worrying about what you cannot control, shift your energy to what you can create.”")
                        .font(Font.custom("Spectral-Medium", size: 18))
                        .padding()
                    
                    Text("― Roy T. Bennett, The Light in the Heart")
                        .font(.custom("SourceCodePro-Regular", size: 14))
                        .foregroundColor(Color.white.opacity(0.7))
                        .padding(.horizontal)
                    
                }
            }
            
            
        }
    }
}

