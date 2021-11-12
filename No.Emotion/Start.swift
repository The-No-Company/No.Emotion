//
//  ContentView.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import SwiftUI

struct Start: View {
    
    @ObservedObject var logic: Logic = LogicAPI
    @ObservedObject var analytics: Analytics = AnalyticsAPI

    @Environment(\.calendar) var calendar
    
    @State private var showing_add = false
    @State var loadNews : Bool = false
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
                        if (!self.logic.monthColors.isEmpty){
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LinearGradient(gradient: Gradient(colors: self.logic.monthColors), startPoint: .top, endPoint: .bottom))
                                .frame(width: 6, alignment: .center)
                                .padding(.vertical)
                                .blur(radius: 2)
                                .drawingGroup()
                        }else{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 6, alignment: .center)
                                .padding(.vertical)
                                .blur(radius: 2)
                                .drawingGroup()
                        }

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

                    if (self.loadNews){
                        newsView()
                            .padding(.horizontal)
                            .padding(.bottom)
                    }else{
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }


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
                        
                        self.logic.add.toggle()
                        
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
        

        
        .sheet(isPresented: self.$logic.add) {
           
        } content: {
            addEmotionView()
                .ignoresSafeArea(.keyboard)

        }
        
        .onAppear{
            SettingsAPI.setupPushNotifications()
            self.logic.getEmotions()
            self.analytics.register()
            self.analytics.send(action: "open")
            self.logic.getTodayNews { result in
                if (result){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation{
                            self.loadNews = result
                        }
                    }
                }
            }
        }

        
    }
}

