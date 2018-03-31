//
//  Extensions+Helpers.swift
//  teste_playground
//
//  Created by Gabriel Oliveira on 17/3/18.
//  Copyright © 2018 Gabriel Oliveira. All rights reserved.
//

import Foundation
import SpriteKit

private let screen = UIScreen.main.bounds
public let height = screen.height
public let width = screen.width
public let magic_number: CGFloat = height / 50
public let magic_height: CGFloat = (magic_number +  (height / 15) / 2) - 6

enum logic_gate: String {
    case and = "and"
    case or = "or"
    case not = "not"
    
    init(fromRawValue: String){
        self = logic_gate(rawValue: fromRawValue) ?? .and
    }
}

enum input: String {
    case one = "input_one"
    case two = "input_two"
    case out = "output"
    
    init(fromRawValue: String){
        self = input(rawValue: fromRawValue) ?? .one
    }
}

extension SKNode {
    func add_physics(retangle_of rect: CGSize) {
        self.physicsBody = SKPhysicsBody(rectangleOf: rect + 30)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = 1
    }
    
    var position_in_scene: CGPoint? {
        if let scene = scene, let parent = parent {
            return parent.convert(position, to: scene)
            
        } else {
            return nil
            
        }
    }
}

extension Bool {
    mutating func toggle() {
        self = !self
    }
}

func + (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width + right, height: left.height + right)
}

