//
//  SettingsOptionsViewModel.swift
//  Messanger-Clone-SwiftUI
//
//  Created by Dev on 09/09/2025.
//

import SwiftUI

enum SettingsOptionsViewModel: Int, Identifiable, CaseIterable {
    
    case darkmode
    case activeStatus
    case accessability
    case privacy
    case notifications
    
    var id: Int { return self.rawValue }
    
    var title: String{
        switch self{
        case .darkmode:  return "DarkMode"
        case .activeStatus: return "Active Status"
        case .accessability: return "Accessability"
        case .privacy: return "Privacy"
        case .notifications: return "Notifications"
        }
    }
    
    var imageName: String{
        switch self{
        case .darkmode:  return "moon.circle.fill"
        case .activeStatus: return "message.badge.circle.fill"
        case .accessability: return "person.circle.fill"
        case .privacy: return "lock.circle.fill"
        case .notifications: return "bell.circle.fill"
        }
    }
    
    var imageBackgroundColor: Color{
        switch self{
        case .darkmode:  return .black
        case .activeStatus: return Color(.systemGreen)
        case .accessability: return .black
        case .privacy: return Color(.systemBlue)
        case .notifications: return Color(.systemPurple)
        }
    }
    
}

