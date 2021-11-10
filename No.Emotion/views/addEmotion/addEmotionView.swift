//
//  addEmotionView.swift
//  No.Emotion
//
//  Created by Michael Safir on 01.11.2021.
//

import Foundation
import SwiftUI
import Introspect

struct addEmotionView: View {
    
    @ObservedObject var logic: Logic = LogicAPI
    @Environment(\.presentationMode) private var presentationMode
    
    @State var text : String = ""
    @State var openView : Bool = false
    @State var percentage: Float = 100
    
    
    @State var dataSelected : [String]  = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 0){
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.clear)
                    .frame(height: 5)
                    .padding(.horizontal, -15)
                
                
                HStack{
                    
                    Text("Add emotion")
                        .font(Font.custom("Spectral-Medium", size: 26))
                    
                    Spacer()
                    
                    
                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        
                        self.logic.addEmotion(emotion: Logic.Emotion(id: 0,
                                                                     bright: self.percentage,
                                                                     date: Date(),
                                                                     tags: self.dataSelected))
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                        
                    }, label: {
                        Image(systemName: "paperplane")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .opacity(self.dataSelected.count == 0 ? 0.3 : 1.0)
                    }).buttonStyle(ScaleButtonStyle())
                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                HStack{
                    Text("Choose your mood")
                        .font(.custom("SourceCodePro-Regular", size: 14))
                        .foregroundColor(Color.secondary.opacity(0.7))
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(self.logic.smiles, id: \.self) { item in
                        Button(action: {
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                            
                            if (self.dataSelected.contains(item)){
                                if let index = self.dataSelected.firstIndex(of: item){
                                    self.dataSelected.remove(at: index)
                                }
                            }else{
                                self.dataSelected.append(item)
                            }
                            
                            
                            
                        }, label: {
                            
                            Text(item)
                                .font(.system(size: 32))
                                .padding()
                                .background(self.dataSelected.contains(item) ? self.logic.getSmileColor(smile: item).opacity(0.3) : Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                                .drawingGroup()
                            
                        })
                            .contentShape(Rectangle())
                            .buttonStyle(ScaleButtonStyle())
                        
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                
                HStack{
                    Text("How bright was the moment?")
                        .font(.custom("SourceCodePro-Regular", size: 14))
                        .foregroundColor(Color.secondary.opacity(0.7))
                    Spacer()
                }
                .padding(.horizontal)
                
                sliderView(percentage: $percentage)
                    .accentColor(Color.secondary.opacity(0.1))
                    .frame(height: 32)
                    .padding(.horizontal)
                    .padding(.vertical)
                
                HStack{
                    Text("You can add an unlimited number of moments during the day. Write down everything that happens to you - moments of happiness and joy, sadness and sorrow. The more you add, the better the picture will be during the month and we will be able to give you useful advice.")
                        .font(.custom("SourceCodePro-Regular", size: 14))
                        .foregroundColor(Color.secondary.opacity(0.7))
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }.onAppear{
            UITextView.appearance().backgroundColor = .clear
        }
    }
}


struct sliderView: View {
    
    @Binding var percentage: Float // or some value binded
    
    var body: some View {
        GeometryReader { geometry in
            // TODO: - there might be a need for horizontal and vertical alignments
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.secondary.opacity(0.05))
                ZStack(alignment: .trailing){
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.accentColor)
                        .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(width: 15, height: 15, alignment: .center)
                        .padding(5)
                    
                    
                }
            }
            .cornerRadius(12)
            .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ value in
                // TODO: - maybe use other logic here
                withAnimation{
                    self.percentage = min(max(0, Float(value.location.x / geometry.size.width * 100)), 100)
                }
            }))
        }
    }
}
