//
//  VideoMessage.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/16.
//

import Foundation
import MessageKit

class VideoMessage: NSObject, MediaItem {
    
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
    init(url: URL?) {
        self.url = url
        self.placeholderImage = UIImage(named: "photoPlaceholder")!
        self.size = CGSize(width: 240, height: 240)
    }
    
}
