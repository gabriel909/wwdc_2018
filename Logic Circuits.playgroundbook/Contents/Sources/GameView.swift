//
//  GameView.swift
//
//  Created by Gabriel Oliveira on 3/17/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import SpriteKit
import PlaygroundSupport

class GameView : SKView{
    fileprivate var _scene : GameScene {
        return scene as! GameScene
    }
}

//Recebimento de mensagens enviadas a partir de Contents.swift
//extension GameView: PlaygroundLiveViewMessageHandler {
//    public func liveViewMessageConnectionOpened() { }
//    
//    ///Chamada quando a contents  para de executar (quando por exemplo o usuario pressiona Stop)
//    public func liveViewMessageConnectionClosed() { }
//    
//    ///Função chamada a partir da GameScene para enviar alguma mensagem para Contents.swift
//    public func sendMessage(_ msg: String){
//        let pv : PlaygroundValue = .string(msg)
//        send(pv)
//    }
//    
//    ///Recebe mensagens
//    public func receive(_ message: PlaygroundValue) {
//        guard let method = message.stringFromDict(withKey: "method") else { return }
//        
//        switch (method) {
//            case "changeTheme":
//                let theme = message.stringFromDict(withKey: "theme")!
//                
//                _scene.changeThemeDef(theme)
//                break
//            
//            case "setGravity":
//                gravity = message.integerFromDict(withKey: "gravity")!
//            
//                _scene.setGravityDef(gravityVector)
//                break
//            
//            case "setImpulse":
//                let impulse = message.integerFromDict(withKey: "impulse")!
//            
//                _scene.setImpulseDef(impulse)
//                break
//            
//            default:
//                break
//        }
//    }
//}

