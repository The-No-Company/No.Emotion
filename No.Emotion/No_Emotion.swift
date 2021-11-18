//
//  No_Emotion.swift
//  No.Emotion
//
//  Created by Michael Safir on 18.11.2021.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "", subtitle: "", image: UIImage(named: "placeholderWidget")!)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        
        NoEmotionProvider.getImageFromApi { response in
            var entries: [SimpleEntry] = []
            var entry: SimpleEntry
            
            switch response{
            case .Failure:
                entry = SimpleEntry(date: Date(), title: "", subtitle: "", image:  UIImage(named: "placeholderWidget")!)
                break
            case .Success(let image, let title, let subtitle):
                entry = SimpleEntry(date: Date(), title: title, subtitle: subtitle, image: image)
                break
            }
            
            completion(entry)
            
        }
        
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        NoEmotionProvider.getImageFromApi { response in
            var entries: [SimpleEntry] = []
            var entry: SimpleEntry
            
            switch response{
            case .Failure:
                entry = SimpleEntry(date: Date(), title: "", subtitle: "", image:  UIImage(named: "placeholderWidget")!)
                break
            case .Success(let image, let title, let subtitle):
                entry = SimpleEntry(date: Date(), title: title, subtitle: subtitle, image: image)
                break
            }
            // Generate a timeline consisting of five entries an hour apart, starting from the current date.
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                entry.date = entryDate
                entries.append(entry)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
            
        }
        
        
        
        
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    var title : String
    var subtitle : String
    var image : UIImage
    
    var relevance: TimelineEntryRelevance? {
        return TimelineEntryRelevance(score: 100)
    }
}

struct No_EmotionEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.colorScheme) var colorScheme
    
    var bgColor: some View {
        colorScheme == .dark ? Color.black : Color.black
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center){
                Image(uiImage: entry.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .blur(radius: 5, opaque: true)
                
                VStack{
                    Text("\(entry.title)")
                        .font(Font.custom("Spectral-Medium", size: 18))
                        .foregroundColor(Color.white)
                        
                    
                    Text("― \(entry.subtitle)")
                        .font(.custom("SourceCodePro-Regular", size: 14))
                        .foregroundColor(Color.white.opacity(0.7))
                        .padding(.horizontal)
                    
                }.padding()
            }
        }
    }
}

@main
struct No_Emotion: Widget {
    let kind: String = "No_Emotion"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            No_EmotionEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("No.Emotion")
        .description("Get new quotes every day.")
    }
}

