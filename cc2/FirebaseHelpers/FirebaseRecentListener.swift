//
//  FirebaseRecentListener.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/14.
//

import Foundation
import Firebase

class FirebaseRecentListener {
    
    static let shared = FirebaseRecentListener()
    
    private init() {}
    
    func addRecent(_ recent: RecentChat) {
        
        do {
            try FirebaseReference(.Recent).document(recent.id).setData(from: recent)
        } catch {
            print(error.localizedDescription)
        }
    }
}
