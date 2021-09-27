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

    @IBOutlet weak var tableView: NSTableView!

    let sortDescriptorScheme = NSSortDescriptor(key: "scheme", ascending: true)
    let sortDescriptorHandler = NSSortDescriptor(key: "handlerString", ascending: true)
    
    @objc var entries: [Entry] = []

    @IBOutlet var arrayController: NSArrayController!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self

        tableView.tableColumns[0].sortDescriptorPrototype = sortDescriptorScheme
        tableView.tableColumns[1].sortDescriptorPrototype = sortDescriptorHandler

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

extension ViewController: NSTableViewDataSource  {
    func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        guard let sortDescriptor = tableView.sortDescriptors.first else {
            return
        }

        arrayController.sortDescriptors = [sortDescriptor]
        arrayController.rearrangeObjects()
    }
}
