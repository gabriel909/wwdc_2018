//
//  GameScene.swift
//  teste_playground
//
//  Created by Gabriel Oliveira on 15/3/18.
//  Copyright © 2018 Gabriel Oliveira. All rights reserved.
//

import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    private var should_move: Bool!
    private var plus_node: button!
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.should_move = false
        
        physicsWorld.contactDelegate = self
        
        plus_node = button(image_name: "plus", action: button_plus_action)
        plus_node.name = "plus_node"
        plus_node.position = CGPoint(x: width - 40, y: 550)
        self.addChild(plus_node)
    }
    
    //MARK: - Touch Lifecycle
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.get_node(at: touches, { (node, touch) in
            if let father_node = node.parent! as? main_node {
                father_node.touched(at: touch.location(in: father_node))
                
            } else if let node = node as? button {
                node.action()
                
            }
        })
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        get_main_node(at: touches, { (father_node, touch) in
            self.should_move = true
            father_node.position = touch.location(in: self)
        })
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        get_main_node(at: touches, { (father_node, touch) in
            if father_node.is_chained != nil || father_node.child != nil && should_move {
                self.should_move = false
                father_node.change_position()
            }
        })
    }
    
    //MARK: - Aux Methods
    private func get_main_node(at touches: Set<UITouch>, _ completion: (main_node, UITouch) -> ()) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if let node = nodes(at: location).first, let father_node = node.parent! as? main_node {
                completion(father_node, touch)
            }
        }
    }
    
    private func get_node(at touches: Set<UITouch>, _ completion: (SKNode, UITouch) -> ()) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if let node = nodes(at: location).first {
                completion(node, touch)
            }
        }
    }
    
    private func remove_add_buttons() {
        self.children.forEach { (node) in
            if node.name!.contains("add") {
                node.removeFromParent()
            }
        }
        
        plus_node.action = button_plus_action
    }
    
    //MARK: - Actions
    private func button_plus_action() {
        let gates: [String] = ["and", "not", "or"]
        
        let add_gate_node = SKSpriteNode(imageNamed: "add_node")
        add_gate_node.name = "add_node"
        add_gate_node.position = CGPoint(x: width - 40, y: 400)
        add_gate_node.zPosition = -1000
        self.addChild(add_gate_node)
        
        var gambi: CGFloat = 0.0
        
        for gate in gates {
            let add_gate_node = button(image_name: "\(gate)_button", action: { self.add(gate) })
            add_gate_node.name = "add_\(gate)"
            add_gate_node.position = CGPoint(x: width - 40, y: 465 + gambi)
            gambi -= 105
            add_gate_node.size = CGSize(width: 100, height: 57)
            self.addChild(add_gate_node)
        }
        
        plus_node.action = remove_add_buttons
    }
    
    private func add(_ gate: String) {
        let node = main_node(named: gate)
        node.name = "main_\(gate)"
        node.position = CGPoint(x: 150, y: 250)
        self.addChild(node)
    }
}

//MARK: - Contact Delegate
extension GameScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        let body_a = contact.bodyA.node as! input_node
        let name_a = body_a.name!
        
        let body_b = contact.bodyB.node as! input_node
        let name_b = body_b.name!
        
        let parent_a = body_a.parent as! main_node
        let parent_b = body_b.parent as! main_node
        
        if name_a.contains("input") && name_b.contains("input") {
            return
        }
        
        if name_a.contains("input") {
            parent_b.chain(node: parent_a, input: input(fromRawValue: name_a))
            
        } else if name_b.contains("input") {
            parent_a.chain(node: parent_b, input: input(fromRawValue: name_b))
            
        }
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        let body_a = contact.bodyA.node as! input_node
        let name_a = body_a.name!
        
        let body_b = contact.bodyB.node as! input_node
        let name_b = body_b.name!
        
        let parent_a = body_a.parent as! main_node
        let parent_b = body_b.parent as! main_node
        
        if name_a.contains("input") {
            parent_b.unchain()
            
        } else if name_b.contains("input") {
            parent_a.unchain()
            
        }
    }
}
