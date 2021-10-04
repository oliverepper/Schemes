//
//  MainViewController.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Cocoa

@_silgen_name("_LSCopySchemesAndHandlerURLs") func LSCopySchemesAndHandlerURLs(_: UnsafeMutablePointer<NSArray?>, _: UnsafeMutablePointer<NSMutableArray?>) -> OSStatus

class MainViewController: NSViewController {
    @objc var entries: NSMutableArray {
        let entries: NSMutableArray = []
        var s: NSArray?
        var u: NSMutableArray?
        if (LSCopySchemesAndHandlerURLs(&s, &u) != 0) {
            print("ERROR")
            return entries
        }
        guard let schemes = s, let handlerURLs = u else { return entries }
        for (idx, scheme) in schemes.enumerated() {
            entries.add(Entry(scheme: scheme as! String, handler: handlerURLs[idx] as! URL))
        }
        return entries
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
