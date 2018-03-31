//import PlaygroundSupport
//
//public class Listener : PlaygroundRemoteLiveViewProxyDelegate {
//    
//    private weak var page : PlaygroundPage?
//    
//    public init(page : PlaygroundPage) {
//        self.page = page
//        if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy{
//            proxy.delegate = self
//        }
//    }
//    
//    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) { }
//    
//    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue) {
//        let msg = message.toString()!
//        if msg == "finished" {
//            page?.finishExecution()
//        }
//    }
//}

