//
//  GlobalFunctions.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/11.
//

import Foundation

func fileNameFrom(fileUrl: String) -> String {
        
    return ((fileUrl.components(separatedBy: "_").last)!.components(separatedBy: "?").first!).components(separatedBy: ".").first!
}

func timeElapsed(_ date: Date) -> String {
    
}
