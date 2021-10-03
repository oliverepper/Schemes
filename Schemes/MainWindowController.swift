//
//  MainWindowController.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        contentViewController = MainViewController()
    }
}
