//
//  iconsView.swift
//  NoEmotion
//
//  Created by Michael Safir on 17.11.2021.
//

import SwiftUI
import UIKit

struct iconsView: View {
    @ObservedObject var iconSettings : IconNames = IconNamesAPI
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0 ..< iconSettings.iconNames.count){i in
                VStack(spacing : 10){
                    Image(uiImage: UIImage(named: (self.iconSettings.iconNames[i] ?? Bundle.main.icon)!) ?? UIImage())
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 60, height: 60, alignment: .leading)
                        .cornerRadius(8)
                        .onTapGesture{
                            let setIcon = self.iconSettings.iconNames[i] ?? "AppIcon"
                            
                            if (setIcon == "AppIcon"){
                                UIApplication.shared.setAlternateIconName(nil, completionHandler: { error in
                                    print(String(describing: error))
                                })
                            }
                            
                            UIApplication.shared.setAlternateIconName(setIcon, completionHandler: {
                                error in
                                if let error = error {
                                    print(error.localizedDescription)
                                } else {
                                    print("Success!")
                                }
                            })
                            
                        }
                    Text(self.iconSettings.iconNames[i] ?? "Standart")
                        .font(.custom("SourceCodePro-Regular", size: 14))
                }
            }
        }
    }
}

extension Bundle {
    public var icon: String? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return lastIcon
        }
        return nil
    }
}
