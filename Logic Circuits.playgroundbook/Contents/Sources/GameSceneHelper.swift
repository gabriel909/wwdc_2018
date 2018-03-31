//
//  GameSceneHelper.swift
//
//  Created by Gabriel Oliveira.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit
import SpriteKit

// CGPoint Operators
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

// Random functions for characters positions
func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

// Physics colision map struct
struct PhysicsCategory {
    static let Player   : UInt32 = 0x1 << 1
    static let Floor    : UInt32 = 0x1 << 2
    static let Tube     : UInt32 = 0x1 << 3
    static let Score    : UInt32 = 0x1 << 4
}

public extension SKNode {
    func addPhysics(rectangleOf rect: CGSize, category: UInt32, collision: UInt32, contact: UInt32, gravity: Bool, dynamics: Bool) {
        self.physicsBody = SKPhysicsBody(rectangleOf: rect)
        self.physicsBody?.categoryBitMask = category
        self.physicsBody?.collisionBitMask = collision
        self.physicsBody?.contactTestBitMask = contact
        self.physicsBody?.affectedByGravity = gravity
        self.physicsBody?.isDynamic = dynamics
    }
}
