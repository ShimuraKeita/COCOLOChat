//
//  Channel.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/17.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Channel: Codable {
    
    var id = ""
    var name = ""
    var adminId = ""
    var memberIds = [""]
    var avaterLink = ""
    var aboutChannel = ""
    @ServerTimestamp var createdDate = Date()
    @ServerTimestamp var lastMessageDate = Date()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case adminId
        case memberIds
        case avaterLink
        case aboutChannel
        case createdDate
        case lastMessageDate = "date"
    }
}
