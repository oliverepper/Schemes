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

    @objc lazy var entries: NSMutableArray = {
        let entries: NSMutableArray = []
        loadData(into: entries)
        return entries
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func loadData(into array: NSMutableArray) {
        var s: NSArray?
        var u: NSMutableArray?
        if (LSCopySchemesAndHandlerURLs(&s, &u) != 0) {
            print("ERROR")
            return
        }
        guard let schemes = s, let handlerURLs = u else { return }
        for (idx, scheme) in schemes.enumerated() {
            array.add(Entry(scheme: scheme as! String, handler: handlerURLs[idx] as! URL))
        }
    }

    @IBAction func reloadData(_ sender: Any) {
        entries.removeAllObjects()
        loadData(into: entries)
        arrayController.rearrangeObjects()
    }
}
