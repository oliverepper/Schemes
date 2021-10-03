//
//  MainViewController.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var infoLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.stringValue = ProcessInfo.processInfo.processName
    }
    
}
