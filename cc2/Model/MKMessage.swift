//
//  MKMessage.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/14.
//

import Foundation
import MessageKit
import CoreLocation

class MKMessage: NSObject, MessageType {
    
    var messageId: String
    var kind: MessageKind
    var sentDate: Date
    var incoming: Bool
    var mkSender: MKSender
    var sender: SenderType { return mkSender }
    var senderInitials: String
    
    var status: String
    var readDate: Date
    
    init(message: String) {
        
    }
}
