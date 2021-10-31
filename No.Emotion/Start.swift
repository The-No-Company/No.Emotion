//
//  ContentView.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import SwiftUI

struct Start: View {
    
    @ObservedObject var logic: Logic = LogicAPI
    @Environment(\.calendar) var calendar
    
    private var header: some View {
        let component = calendar.component(.month, from: Date())
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        return Text(formatter.string(from: Date()))
            .font(Font.custom("Spectral-Medium", size: 26))
            .foregroundColor(Color.white)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 5){
                        Text("No.Emotion")
                            .font(Font.custom("Spectral-Medium", size: 20))
                        Divider()
                        self.header
                    }
                    Spacer()
                    
                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }, label: {
                        Image(systemName: "gear")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                    })
                        .buttonStyle(ScaleButtonStyle())
                        .padding(.leading)
                    
                }.padding(.horizontal)
                ScrollView(.vertical, showsIndicators: false){
                    HStack{
                        RootView()
                            .padding(.vertical)
                        Spacer()
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(gradient: Gradient(colors: [.green, .green, .red, .yellow, .green, .red, .green]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 6, alignment: .center)
                            .padding(.vertical)
                            .blur(radius: 2)
                        
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("Timeline")
                            .font(Font.custom("Spectral-Medium", size: 26))
                            .foregroundColor(Color.white)
                        Spacer()
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("Quotes added daily to lift your spirits")
                            .font(.custom("SourceCodePro-Regular", size: 14))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    newsView()
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    
                    HStack{
                        Text("Add a quote widget to the desktop")
                            .font(.custom("SourceCodePro-Regular", size: 14))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    
                    Spacer(minLength: 120)
                }
            }
            
            if #available(iOS 15.0, *) {
                HStack{
                    HStack{
                        Image(systemName: "quote.bubble")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .offset(y: -5)
                        
                        
                        Text("New emotion")
                            .font(Font.custom("Spectral-Medium", size: 18))
                            .offset(y: -5)
                    }.padding(.horizontal)
                    
                    Spacer()
                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        
                    }, label: {
                        ZStack{
                            Circle()
                                .fill(Color.white)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .medium, design: .rounded))
                                .foregroundColor(.black)
                        }
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding()
                        
                        .clipped()
                        
                        
                        
                        
                    })
                        .offset(y: -5)
                        .contentShape(Rectangle())
                        .buttonStyle(ScaleButtonStyle())
                }
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                
            }
            
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea(.all, edges: .bottom)
        .ignoresSafeArea(.keyboard)
        .onAppear{
            
        }
    }
}

