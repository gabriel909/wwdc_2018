//
//  MainNode.swift
//  teste_playground
//
//  Created by Gabriel Oliveira on 15/3/18.
//  Copyright © 2018 Gabriel Oliveira. All rights reserved.
//

import UIKit
import SpriteKit

public class main_node: SKNode {
    public var input_one: input_node!
    public var input_two: input_node!
    public var output: input_node!
    
    var is_chained: input?
    
    private var gate: SKSpriteNode!
    var child: (node: main_node, input: input)?
    
    public var father: main_node?
    
    private var logic: logic_gate!
    
    public init(named: String) {
        super.init()
        
        self.input_one = input_node()
        self.input_two = input_node()
        self.output = input_node()
        
        self.is_chained = nil
        self.gate = input_node()
        
        self.father = nil
        
        self.child = nil
        
        self.logic = logic_gate(fromRawValue: named)
        
        self.gate = SKSpriteNode(imageNamed: named)
        self.gate.position = CGPoint(x: 0, y: 0)
        self.gate.zPosition = 1000
        self.gate.name = "gate"
        self.addChild(gate)
        
        let input_y: CGFloat = (named != "not") ? magic_number : 0.0
        
        self.input_one.position = CGPoint(x: ((5 * -input_one.size.width) / 4) + 5, y: input_y)
        self.input_one.name = "input_one"
        self.input_one.add_physics(retangle_of: self.input_one.size)
        self.addChild(input_one)
        
        if named != "not" {
            self.input_two.position = CGPoint(x: ((5 * -input_two.size.width) / 4) + 5, y: -magic_number)
            self.input_two.name = "input_two"
            self.input_two.add_physics(retangle_of: self.input_two.size)
            self.addChild(input_two)
        }
        
        self.output.position = CGPoint(x: (5 * gate.size.width) / 7, y: 0)
        self.output.name = "output"
        self.output.add_physics(retangle_of: self.output.size)
        self.addChild(output)
        
        self.input_changed()
    }
    
    public func touched(at position: CGPoint) {
        if let node = self.nodes(at: position).first {
            if node.name == "output" || node.name == "gate" {
                return
            }
            
            let input = node as! input_node
            let value = input.get_bool_value()
            
            input.change_input(to: !value)
            self.input_changed()
        }
    }
    
    private func input_changed() {
        let value_input_one = self.input_one.get_bool_value()
        let value_input_two = self.input_two.get_bool_value()
        var value_output = false
        
        switch logic {
        case .and:
            value_output = value_input_one && value_input_two
            
        case .or:
            value_output = value_input_one || value_input_two
            
        case .not:
            value_output = !value_input_one
            
        default:
            break
        }
        
        output.change_input(to: value_output)
        
        if let _ = child {
            if child!.input == .one {
                child!.node.input_one.change_input(to: value_output)
                
            } else if child!.input == .two {
                child!.node.input_two.change_input(to: value_output)
                
            }
            
            child!.node.input_changed()
        }
    }
    
    func chain(node: main_node, input: input) {
        self.child = (node, input)
        let output_value = self.output.get_bool_value()
        
        if input == .one {
            node.input_one.change_input(to: output_value)
            node.is_chained = .one
            
        } else if input == .two {
            node.input_two.change_input(to: output_value)
            node.is_chained = .two
            
        }
        
        node.father = self
        node.input_changed()
    }
    
    public func unchain() {
        if self.output.input_label.parent == nil {
            self.output.add_input_label()
        }
        
        let input = self.child?.input
        
        if self.child?.node.name! != "main_not" {
            if input == .one {
                self.child?.node.input_one.change_input_type(chained: false)
                
            } else {
                self.child?.node.input_two.change_input_type(chained: false)
                
            }
        }
        
        self.child?.node.input_changed()
        self.input_changed()
        self.child?.node.is_chained = nil
        self.child?.node.father = nil
        self.child = nil
    }
    
    func change_position(with_input input: input? = .one) {
        var position = CGPoint()
        let father_frame = father?.calculateAccumulatedFrame()
        let output_pos = father?.output.position_in_scene!
        let self_size = self.calculateAccumulatedFrame().size
        
        if let _ = self.is_chained {
            father?.output.input_label.removeFromParent()
            
            if self.name == "main_not" {
                position.x = father_frame!.maxX + (self_size.width / 2) - 10
                position.y = output_pos!.y
                
            } else {
                switch is_chained! {
                case .one:
                    self.input_one.change_input_type(chained: true)
                    position.x = father_frame!.maxX + (self_size.width / 2) - 10
                    position.y = output_pos!.y - 3 * (magic_height / 2) + 7
                    
                case .two:
                    self.input_two.change_input_type(chained: true)
                    position.x = father_frame!.maxX + (self_size.width / 2) - 10
                    position.y = output_pos!.y + 3 * (magic_height / 2) - 7
                    
                default:
                    break
                    
                }
            }
            
        } else if let _ = self.child {
            self.output.input_label.removeFromParent()
            
            if child?.node.name == "main_not" {
                position.x = child!.node.frame.minX - (self_size.width) + 10
                position.y = child!.node.position.y
                
            } else {
                switch child!.input {
                case .one:
                    child?.node.input_one.change_input_type(chained: true)
                    position.x = child!.node.frame.minX - (self_size.width) + 7
                    position.y = child!.node.position.y + 3 * (magic_height / 2) - 6.5
                    
                case .two:
                    child?.node.input_two.change_input_type(chained: true)
                    position.x = child!.node.frame.minX - (self_size.width) + 7
                    position.y = child!.node.position.y - 3 * (magic_height / 2) + 6.5
                    
                default:
                    break
                    
                }
            }
        }
        
        self.position = position
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class input_node: SKSpriteNode {
    public var input_label: SKLabelNode!
    private var texture_name: String!
    private var chained: Bool = false
    
    public init() {
        self.texture_name = "true"
        let texture = SKTexture(imageNamed: "true")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.add_input_label()
    }
    
    public func change_input(to bool: Bool) {
        var image_name: String = ""
        var name_array = self.texture_name.split(separator: "_")
        
        name_array[name_array.count - 1] = String.SubSequence("\(bool)")
        image_name = name_array.joined(separator: "_")
        self.texture_name = image_name
        
        input_label.text = "\(bool)"
        self.texture = SKTexture(imageNamed: image_name)
    }
    
    public func change_input_type(chained: Bool) {
        self.chained = chained
        let image_name: String = chained ? "\(self.name ?? "")_chained_true" : "true"
        let label_pos: CGPoint = chained ? CGPoint(x: 10, y: -10) : CGPoint(x: -10, y: 10)
        let pos_y: CGFloat
        
        let texture = SKTexture(imageNamed: image_name)
        self.texture_name = image_name
        
        self.texture = texture
        self.size = texture.size()
        
        if self.name!.contains("two") && chained {
            self.input_label.position = CGPoint(x: -10, y: 25)
            
        }
        
        pos_y = chained ? magic_height : magic_number
        self.position.y = self.name!.contains("two") ? -pos_y : pos_y
        self.add_physics(retangle_of: texture.size())
    }
    
    public func add_input_label(with_value value: Bool? = true) {
        let pos = chained ? CGPoint(x: 10, y: -20) : CGPoint(x: -10, y: 10)
        input_label = SKLabelNode(text: "\(value!)")
        input_label.position = pos
        input_label.fontSize = 15
        self.addChild(input_label)
    }
    
    public func get_bool_value() -> Bool {
        return Bool(input_label.text!)!
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class button: SKSpriteNode {
    public var action: (() -> ())!
    
    public init(image_name: String, action: (() -> ())? = { }) {
        let texture: SKTexture = SKTexture(imageNamed: image_name)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.action = action!
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
