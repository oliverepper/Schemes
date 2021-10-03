//
//  Entry.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Foundation

final class Entry: NSObject {
    @objc var scheme: String
    @objc var handler: URL

    init(scheme: String, handler: URL) {
        self.scheme = scheme
        self.handler = handler
    }

    override init() {
        self.scheme = "scheme"
        self.handler = URL(string: "file:///Applications/")!
        super.init()
    }
}

extension NSURL {
    @objc func compare(_ other: NSURL) -> ComparisonResult {
        (self.absoluteString ?? "").compare(other.absoluteString ?? "")
    }
}
