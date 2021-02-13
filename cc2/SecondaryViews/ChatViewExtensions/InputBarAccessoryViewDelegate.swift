//
//  InputBarAccessoryViewDelegate.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/14.
//

import Foundation
import InputBarAccessoryView

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        
        if text != "" {
            print("typing...")
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        for component in inputBar.inputTextView.components {
            if let text = component as? String {
                print("send message with text",text)
            }
        }
        
        messageInputBar.inputTextView.text = ""
        messageInputBar.invalidatePlugins()
    }
}
