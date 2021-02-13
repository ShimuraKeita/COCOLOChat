//
//  RecentChat.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/13.
//

import Foundation
import FirebaseFirestoreSwift

struct RecentChat: Codable {
    
    var id = ""
    var chatRoomId = ""
    var senderId = ""
    var senderName = ""
    var receiverId = ""
    var receiverName = ""
    @ServerTimestamp var date = Date()
    var memberIds = [""]
    var lastMessage = ""
    var unreadConter = 0
    var avatarLink = ""
}
