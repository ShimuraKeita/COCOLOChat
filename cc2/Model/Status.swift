//
//  Status.swift
//  cc2
//
//  Created by 志村　啓太 on 2021/02/13.
//

import Foundation

enum Status: String, CaseIterable {
    case Available = "Available"
    case Busy = "Busy"
    case AtSchool = "AtSchool"
    case AtTheMovies = "At The Movies"
    case AtWork = "At Work"
    case BatteryAboutToDie = "Battery About To Die"
    case CantTalk = "Can't Talk"
    case InAMeeting = "In a Meeting"
    case AtTheGym = "At The Gym"
    case Sleeping = "Sleeping"
    case UrgentCallOnly = "Urgent Call Only"
}
