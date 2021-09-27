//
//  ViewController.swift
//  Schemes
//
//  Created by Oliver Epper on 27.09.21.
//

import Cocoa
import OSLog

@_silgen_name("_LSCopySchemesAndHandlerURLs") func LSCopySchemesAndHandlerURLs(_: UnsafeMutablePointer<NSArray?>, _: UnsafeMutablePointer<NSMutableArray?>) -> OSStatus


class ViewController: NSViewController {

    @objc var entries: [Entry] = []

    @IBOutlet var arrayController: NSArrayController!

    override func viewDidLoad() {
        super.viewDidLoad()

        var schemes: NSArray?
        var handlers: NSMutableArray?
        if (LSCopySchemesAndHandlerURLs(&schemes, &handlers) != 0) {
            os_log("Cannot load Information", type: .error)
        } else {
            guard let s = schemes, let h = handlers else { return }

            for (i, elem) in s.enumerated() {
                arrayController.addObject(Entry(scheme: elem as! String, handler: h[i] as! CFURL))
            }
        }
    }
}
