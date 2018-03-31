import SpriteKit
import PlaygroundSupport

public func startScene() -> GameScene {
    let skV = GameView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
    let scene = GameScene(size: skV.frame.size)
    skV.presentScene(scene)
    scene.scaleMode = .aspectFill
    scene.size = skV.bounds.size

    let page = PlaygroundPage.current
    page.liveView = skV
    
    return scene
}
