//
//  MainViewController.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Cocoa

class MainViewController: NSViewController {

    @objc var entries: NSMutableArray = [
        Entry(scheme: "https", handler: URL(string: "file:///Applications/Safari.app")!),
        Entry(scheme: "mailto", handler: URL(string: "file:///Applications/Mail.app")!),
        Entry(scheme: "callto", handler: URL(string: "file:///Applications/Starface.app")!),
        Entry(scheme: "test", handler: URL(string: "file:///Applications/Starface.app")!),
        Entry(scheme: "Test", handler: URL(string: "file:///Applications/Starface.app")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
