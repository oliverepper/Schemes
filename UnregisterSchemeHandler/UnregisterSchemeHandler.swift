//
//  UnregisterSchemeHandler.m
//  UnregisterSchemeHandler
//
//  Created by Oliver Epper on 04.10.21.
//

import Foundation

@_silgen_name("_LSUnregisterURL") func LSUnregisterURL(_: NSURL) -> OSStatus

class UnregisterSchemeHandler: NSObject, UnregisterSchemeHandlerProtocol {
    func unregister(_ url: URL, withReply reply: @escaping (Int32) -> Void) {
        let result = LSUnregisterURL(url as NSURL)
        reply(result)
    }
}
