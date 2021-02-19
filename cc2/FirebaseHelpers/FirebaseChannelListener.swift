//
//  FirebaseChannelListener.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/19.
//

import Foundation
import Firebase

class FirebaseChannelListener {
    
    static let shared = FirebaseChannelListener()
    
    var channelListener: ListenerRegistration!
    
    private init() { }
    
    //MARK: - Fetching
    
    //MARK: - Add Update Delete
    func addChannel(_ channel: Channel) {
        
        do {
            try FirebaseReference(.Channel).document(channel.id).setData(from: channel)
        } catch {
            print("Error saving channel ", error.localizedDescription)
        }
        
    }
}
