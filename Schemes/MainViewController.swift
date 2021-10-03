//
//  MainViewController.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Cocoa

@_silgen_name("_LSCopySchemesAndHandlerURLs") func LSCopySchemesAndHandlerURLs(_: UnsafeMutablePointer<NSArray?>, _: UnsafeMutablePointer<NSMutableArray?>) -> OSStatus

class MainViewController: NSViewController {

    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet weak var tableView: NSTableView!
    @objc var entries: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        var s: NSArray?
        var u: NSMutableArray?
        if (LSCopySchemesAndHandlerURLs(&s, &u) != 0) {
            print("ERROR")
            return
        }
        guard let schemes = s, let handlerURLs = u else { return }
        for (idx, scheme) in schemes.enumerated() {
            entries.add(Entry(scheme: scheme as! String, handler: handlerURLs[idx] as! URL))
        }

        arrayController.rearrangeObjects()
    }
}
