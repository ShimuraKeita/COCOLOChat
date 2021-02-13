//
//  MessageDataSource.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/14.
//

import Foundation
import MessageKit

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return mkMessages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        mkMessages.count
    }
    
    
}
