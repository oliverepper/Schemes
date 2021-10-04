//
//  main.m
//  UnregisterSchemeHandler
//
//  Created by Oliver Epper on 04.10.21.
//

import Foundation

let delegate = UnregisterSchemeHandlerDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate
listener.resume()
