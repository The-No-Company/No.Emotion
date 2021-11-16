//
//  settingsView.swift
//  NoEmotion
//
//  Created by out-safir-md on 16.11.2021.
//

import SwiftUI

struct settingsView: View {
    
    @ObservedObject var logic: Logic = LogicAPI
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var icloud : Bool = true
    @State private var haptic : Bool = true
    @State private var notifications : Bool = true
    
    init(){
        UISwitch.appearance().thumbTintColor = UIColor.black.withAlphaComponent(0.85)
    }
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 10){
                    VStack(spacing: 10){
                        HStack{
                            Text("Preferences")
                                .font(Font.custom("Spectral-Medium", size: 26))
                            
                            Spacer()
                            
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "xmark.circle")
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                                    .opacity(0.5)
                            }).buttonStyle(ScaleButtonStyle())
                            
                        }
                        .padding(.horizontal, 20)
                        
                        HStack{
                            Text("Personalize the app to suit your needs. Control notifications, colors, and the app icon .")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .foregroundColor(Color.secondary.opacity(0.7))
                            
                            Spacer()
                        } .padding(.horizontal, 20)
                        
                    }.padding(.top)
                    
                    VStack(spacing: 10){
                        HStack{
                            Text("General")
                                .font(Font.custom("Spectral-Medium", size: 20))
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .padding(.horizontal, 20)
                            .frame(height: 2)
                        
                    }
                    .padding(.bottom, 10)
                    
                    
                    VStack(spacing: 0){
                        HStack{
                            Text("Use Haptic Feedback")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                            if #available(iOS 15.0, *) {
                                Toggle("", isOn: $haptic)
                                    .tint(Color.white)
                            } else {
                                Toggle("", isOn: $haptic)
                                    .accentColor(Color.white)
                            }
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 2)
                            .padding(.vertical, 10)
                        
                        HStack{
                            Text("Notifications")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                            if #available(iOS 15.0, *) {
                                Toggle("", isOn: $notifications)
                                    .tint(Color.white)
                            } else {
                                Toggle("", isOn: $notifications)
                                    .accentColor(Color.white)
                            }
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 2)
                            .padding(.vertical, 10)
                        
                        HStack{
                            Text("iCloud Sync and Backup")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                            if #available(iOS 15.0, *) {
                                Toggle("", isOn: $icloud)
                                    .tint(Color.white)
                            } else {
                                Toggle("", isOn: $icloud)
                                    .accentColor(Color.white)
                            }
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 2)
                            .padding(.vertical, 10)
                        
                        HStack{
                            Text("Icon")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                           Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                            
                        }.padding(.vertical, 5)
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.init(hex: "2A2A2A"))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 10){
                        HStack{
                            Text("Community")
                                .font(Font.custom("Spectral-Medium", size: 20))
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .padding(.horizontal, 20)
                            .frame(height: 2)
                        
                    }
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    
                    VStack(spacing: 0){
                        HStack{
                            Text("Share with Your Friends")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                           Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                            
                        }.padding(.vertical, 5)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 2)
                            .padding(.vertical, 10)
                        
                        HStack{
                            Text("Rate Us on the App Store")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                           Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                            
                        }.padding(.vertical, 5)
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.init(hex: "2A2A2A"))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 10){
                        HStack{
                            Text("Application")
                                .font(Font.custom("Spectral-Medium", size: 20))
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .padding(.horizontal, 20)
                            .frame(height: 2)
                        
                    }
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    
                    VStack(spacing: 0){
                        HStack{
                            Text("Send Us Your Feedback")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                           Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                            
                        }.padding(.vertical, 5)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 2)
                            .padding(.vertical, 10)
                        
                        HStack{
                            Text("Onboarding")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                           Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                            
                        }.padding(.vertical, 5)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 2)
                            .padding(.vertical, 10)
                        
                        HStack{
                            Text("Terms of Service")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                           Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                            
                        }.padding(.vertical, 5)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 2)
                            .padding(.vertical, 10)
                        
                        HStack{
                            Text("Privacy")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                           Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                            
                        }.padding(.vertical, 5)
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.init(hex: "2A2A2A"))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)

                    
                }
            }
        }
    }
}

