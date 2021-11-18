//
//  settingsView.swift
//  NoEmotion
//
//  Created by out-safir-md on 16.11.2021.
//

import SwiftUI
import Combine

struct settingsView: View {
    
    @ObservedObject var logic: Logic = LogicAPI
    @Environment(\.presentationMode) private var presentationMode
    
    @State  var icloud : Bool = true
    @State  var haptic : Bool = true
    @State  var notifications : Bool = true
    
    @Environment(\.openURL) var openURL
    
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
                            
                        }.onChange(of: Just(self.haptic)) { result in
                            print("Haptic - \(self.haptic)")
                            UserDefaults.standard.set(self.haptic, forKey: "haptic")
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
                            
                        }.onChange(of: Just(self.notifications)) { result in
                            print("Notifications - \(self.notifications)")
                            UserDefaults.standard.set(self.notifications, forKey: "notifications")
                            
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
                            
                        }.onChange(of: Just(self.icloud)) { result in
                            print("iCloud - \(self.icloud)")
                            UserDefaults.standard.set(self.icloud, forKey: "icloud")
                        }
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 2)
                            .padding(.vertical, 10)
                        
                        HStack{
                            Text("Icons: ")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()

                        }
                        
                        
                        iconsView()
                            .padding(.vertical)
                        
                        
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
                            
                        }
                        .padding(.vertical, 5)
                        .onTapGesture {
                            openURL(URL(string: SettingsAPI.feedback)!)
                        }
                        
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
                            
                        }
                        .padding(.vertical, 5)
                        .onTapGesture {
                            openURL(URL(string: SettingsAPI.terms)!)
                        }
                        
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
                            
                        }
                        .padding(.vertical, 5)
                        .onTapGesture {
                            openURL(URL(string: SettingsAPI.policy)!)
                        }
                        
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
                            Text("Rate Us on the App Store")
                                .font(.custom("SourceCodePro-Regular", size: 14))
                                .fixedSize()
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                            
                        }
                        .padding(.vertical, 5)
                        .onTapGesture {
                            openURL(URL(string: SettingsAPI.rate)!)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.init(hex: "2A2A2A"))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                }
            }
        }.onAppear{
            print("openSettings")
            
            self.haptic = UserDefaults.standard.bool(forKey: "haptic")
            self.icloud = UserDefaults.standard.bool(forKey: "icloud")
            self.notifications = UserDefaults.standard.bool(forKey: "notifications")
            
        }
    }
}

