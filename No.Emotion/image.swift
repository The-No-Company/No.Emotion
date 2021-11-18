//
//  image.swift
//  NoEmotion
//
//  Created by Michael Safir on 18.11.2021.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

enum NoEmotionResponse {
    case Success(image: UIImage, title: String, subtitle: String)
    case Failure
}


class NoEmotionProvider {
    static func getImageFromApi(completion: ((NoEmotionResponse) -> Void)?) {
        
        AF.request("https://service.api.thenoco.co/noemotion/widget", method: .get).responseJSON { (response) in
            if (response.value != nil) {
                let json = JSON(response.value!)
                if (json.count > 0){
                    
                    self.getImage(image: json[0]["img"].string!) { success, image in
                        if (success){
                            
                            completion!(NoEmotionResponse.Success(image: image,
                                                                  title: json[0]["title"].string!,
                                                                  subtitle: json[0]["subtitle"].string!))
                        }
                    }
                    
                }else{
                    completion!(NoEmotionResponse.Failure)
                }
            }else{
                completion!(NoEmotionResponse.Failure)
            }
        }
        
    }
    
    static func getImage(image: String, completionHandler: @escaping (_ success:Bool, _ image:UIImage) -> Void) {
        
        
        let url = URL(string: image)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            
            guard error == nil, let content = data else {
                print("error getting image data")
                completionHandler(false, UIImage())
                return
            }
            
            let image = UIImage(data: content)!
            completionHandler(true, image)
        }
        task.resume()
        
    }
    
    
}
