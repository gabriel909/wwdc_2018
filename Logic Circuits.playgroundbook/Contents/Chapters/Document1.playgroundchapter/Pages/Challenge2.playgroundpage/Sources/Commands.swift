//
//import SpriteKit
//import PlaygroundSupport
//
//public func changeTheme(_ theme: Themes) {
//    sendProxy(PlaygroundValue.dictionary([
//        "method": .string("changeTheme"),
//        "theme": .string(theme.rawValue)
//    ]))
//}
//
//public func setGravity(_ gravity: CGFloat) {
//    sendProxy(PlaygroundValue.dictionary([
//        "method": .string("setGravity"),
//        "gravity": .integer(Int(-gravity))
//    ]))
//}
//
//public func setImpulse(_ impulse: Int) {
//    sendProxy(PlaygroundValue.dictionary([
//        "method": .string("setImpulse"),
//        "impulse": .integer(impulse)
//    ]))
//}
//
//private func sendProxy(_ pv : PlaygroundValue){
//    let page = PlaygroundPage.current
//    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
//        proxy.send(pv)
//    }
//}

