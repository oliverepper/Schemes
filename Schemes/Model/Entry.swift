//
//  Entry.swift
//  Schemes
//
//  Created by Oliver Epper on 27.09.21.
//

import Foundation

final class Entry: NSObject {
    @objc var scheme: String
    var handler: URL
    @objc var handlerString: String {
        handler.description
    }

    init(scheme: String, handler: CFURL) {
        self.scheme = scheme
        self.handler = handler as URL
    }
}
