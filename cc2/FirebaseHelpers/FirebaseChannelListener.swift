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
    func downloadUserChannelsFromFirebase(completion: @escaping(_ allChannels: [Channel]) -> Void) {
        
        channelListener = FirebaseReference(.Channel).whereField(kADMINID, isEqualTo: User.currentId).addSnapshotListener({ (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("no documents for user channels")
                return
            }
            
            var allChannels = documents.compactMap { (queryDocumentSnapshot) -> Channel? in
                return try? queryDocumentSnapshot.data(as: Channel.self)
            }
            
            allChannels.sort(by: { $0.memberIds.count > $1.memberIds.count })
            completion(allChannels)
        })
    }
    
    //MARK: - Add Update Delete
    func addChannel(_ channel: Channel) {
        
        do {
            try FirebaseReference(.Channel).document(channel.id).setData(from: channel)
        } catch {
            print("Error saving channel ", error.localizedDescription)
        }
    }
    
    func deleteChannel(_ channel: Channel) {
        FirebaseReference(.Channel).document(channel.id).delete()
    }
}
