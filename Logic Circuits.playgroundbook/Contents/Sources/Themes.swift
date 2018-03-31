//
//  Themes.swift
//
//  Created by Gabriel Oliveira on 28/3/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

public enum Themes: String {
    case SciFi
    case Spooky
    case Medieval
}

public struct Theme {
    var bg: String!
    var player: String!
    var tube: String!
    
    public init(theme: String) {
        switch theme {
        case "SciFi":
            bg = "bgSciFi"
            player = "playerSciFi"
            tube = "tuboSciFi"
            break
            
        case "Spooky":
            bg = "bgSpooky"
            player = "playerSpooky"
            tube = "tuboSpooky"
            break
            
        case "Medieval":
            bg = "bgMedieval"
            player = "playerMedieval"
            tube = "tuboMedieval"
            break
            
        default:
            break
        }
    }
}
