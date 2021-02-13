//
//  LocalMessage.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/14.
//

import Foundation
import RealmSwift

class LocalMessage: Object, Codable {
    
    @objc dynamic var id = ""
    @objc dynamic var chatRoomId = ""
    @objc dynamic var date = Date()
    @objc dynamic var senderName = ""
    @objc dynamic var senderId = ""
    @objc dynamic var senderinitials = ""
    @objc dynamic var readDate = Date()
    @objc dynamic var type = ""
    @objc dynamic var status = ""
    @objc dynamic var message = ""
    @objc dynamic var audioUrl = ""
    @objc dynamic var videoUrl = ""
    @objc dynamic var pictureUrl = ""
    @objc dynamic var latitude = ""
    @objc dynamic var longitude = ""
    @objc dynamic var audioDuration = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }

}
