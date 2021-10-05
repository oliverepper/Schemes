//
//  UnregisterSchemeHandler.m
//  UnregisterSchemeHandler
//
//  Created by Oliver Epper on 04.10.21.
//

import Foundation

//@_silgen_name("_LSUnregisterURL") func LSUnregisterURL(_: NSURL) -> OSStatus
private let handle = dlopen(nil, RTLD_NOW)
private let fnUnregister = dlsym(handle, "_LSUnregisterURL")
typealias fnUnregisterType = @convention(c) (CFURL) -> OSStatus

class UnregisterSchemeHandler: NSObject, UnregisterSchemeHandlerProtocol {
    func unregister(_ url: URL, withReply reply: @escaping (Int32) -> Void) {
        let LSUnregisterURL = unsafeBitCast(fnUnregister, to: fnUnregisterType.self)
        let result = LSUnregisterURL(url as CFURL)
        reply(result)
    }
}
