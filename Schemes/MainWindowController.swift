//
//  MainWindowController.swift
//  Schemes
//
//  Created by Oliver Epper on 27.09.21.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        contentViewController = ViewController()
    }
    
}
