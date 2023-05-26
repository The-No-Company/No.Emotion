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
                var cachedImage : UIImage = UIImage(named: "placeholderWidget")!
                
                
                let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image.jpg")

                if let fileURL = fileURL {
                    // Create a UIImage instance from the file contents
                    if let image = UIImage(contentsOfFile: fileURL.path) {
                        // Use the retrieved image
                        
                        cachedImage = image
                        // Do something with the UIImage object
                        print("Image loaded successfully")
                    } else {
                        print("Failed to load image")
                    }
                }
                
                
                entry = SimpleEntry(date: Date(), title: UserDefaults.standard.string(forKey: "title") ?? "",
                                    subtitle: UserDefaults.standard.string(forKey: "subtitle") ?? "", image:  cachedImage.resized(toWidth: 800)!)
                break
            case .Success(let image, let title, let subtitle):
                
                let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image.jpg")

                if let fileURL = fileURL {
                    // Convert the image to JPEG representation with a compression quality of 1.0 (highest quality)
                    if let imageData = image.jpegData(compressionQuality: 1.0) {
                        do {
                            // Write the image data to the specified file URL
                            try imageData.write(to: fileURL, options: .atomic)
                            print("Image saved successfully at \(fileURL.path)")
                        } catch {
                            print("Error saving image: \(error)")
                        }
                    }
                }
                
                UserDefaults.standard.set(title, forKey: "title")
                UserDefaults.standard.set(subtitle, forKey: "subtitle")
                
                entry = SimpleEntry(date: Date(), title: title, subtitle: subtitle, image: image.resized(toWidth: 800)!)
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
                
                var cachedImage : UIImage = UIImage(named: "placeholderWidget")!
               
                let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image.jpg")

                if let fileURL = fileURL {
                    // Create a UIImage instance from the file contents
                    if let image = UIImage(contentsOfFile: fileURL.path) {
                        // Use the retrieved image
                        
                        cachedImage = image
                        // Do something with the UIImage object
                        print("Image loaded successfully")
                    } else {
                        print("Failed to load image")
                    }
                }
                
                entry = SimpleEntry(date: Date(), title: UserDefaults.standard.string(forKey: "title") ?? "",
                                    subtitle: UserDefaults.standard.string(forKey: "subtitle") ?? "", image:  cachedImage.resized(toWidth: 800)!)
                break
            case .Success(let image, let title, let subtitle):
                
                let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image.jpg")

                if let fileURL = fileURL {
                    // Convert the image to JPEG representation with a compression quality of 1.0 (highest quality)
                    if let imageData = image.jpegData(compressionQuality: 1.0) {
                        do {
                            // Write the image data to the specified file URL
                            try imageData.write(to: fileURL, options: .atomic)
                            print("Image saved successfully at \(fileURL.path)")
                        } catch {
                            print("Error saving image: \(error)")
                        }
                    }
                }
                
                UserDefaults.standard.set(title, forKey: "title")
                UserDefaults.standard.set(subtitle, forKey: "subtitle")
                
                entry = SimpleEntry(date: Date(), title: title, subtitle: subtitle, image: image.resized(toWidth: 800)!)
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
                
                VStack(spacing: 15){
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


extension UIImage {
  func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
    let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
    let format = imageRendererFormat
    format.opaque = isOpaque
    return UIGraphicsImageRenderer(size: canvas, format: format).image {
      _ in draw(in: CGRect(origin: .zero, size: canvas))
    }
  }
}

