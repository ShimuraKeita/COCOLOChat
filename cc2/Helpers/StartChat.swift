//
//  StartChat.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/13.
//

import Foundation


//MARK: - StartChat
func startChat(user1: User, user2: User) -> String {
    
    
    let chatRoomId = chatRoomIdFrom(user1Id: user1.id, user2Id: user2.id)
    
    createRecentItems(chatRoomId: chatRoomId, users: [user1, user2])
    return chatRoomId
}

func createRecentItems(chatRoomId: String, users: [User]) {
    FirebaseReference(.Recent).whereField(kCHATROOMID, isEqualTo: chatRoomId).getDocuments { (snapshot, error) in
        
    }
}

func chatRoomIdFrom(user1Id: String, user2Id: String) -> String {
    
    var chatRoomId = ""
    
    let value = user1Id.compare(user2Id).rawValue
    
    chatRoomId = value < 0 ? (user1Id + user2Id) : (user2Id + user1Id)
    
    return chatRoomId
}
