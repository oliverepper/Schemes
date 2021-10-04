//
//  UnregisterSchemeHandlerProtocol.h
//  UnregisterSchemeHandler
//
//  Created by Oliver Epper on 04.10.21.
//

import Foundation

@objc public protocol UnregisterSchemeHandlerProtocol {
    func unregister(_ url: URL, withReply reply: @escaping (Int32) -> Void)
}
