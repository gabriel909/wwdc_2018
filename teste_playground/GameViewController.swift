//
//  GameViewController.swift
//  teste_playground
//
//  Created by Gabriel Oliveira on 15/3/18.
//  Copyright © 2018 Gabriel Oliveira. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let view = self.view as! SKView? {
        //            // Load the SKScene from 'GameScene.sks'
        //            if let scene = SKScene(fileNamed: "GameScene") {
        //                // Set the scale mode to scale to fit the window
        //                scene.scaleMode = .aspectFill
        //
        //                // Present the scene
        //                view.presentScene(scene)
        //            }
        
//        let view = SKView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
//        let scene = GameScene(size: view.frame.size)
//        scene.scaleMode = .aspectFill
//        scene.size = view.bounds.size
//
//        view.ignoresSiblingOrder = true
//
//        view.showsFPS = true
//        view.showsNodeCount = true
//        view.presentScene(scene)

        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        
        skView.presentScene(scene)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
