//
//  UnregisterSchemeHandler.h
//  UnregisterSchemeHandler
//
//  Created by Oliver Epper on 04.10.21.
//

import Foundation

class UnregisterSchemeHandlerDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: UnregisterSchemeHandlerProtocol.self)
        newConnection.exportedObject = UnregisterSchemeHandler()
        newConnection.resume()
        
        return true
    }
}
