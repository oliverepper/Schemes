//
//  AppDelegate.swift
//  Schemes
//
//  Created by Oliver Epper on 27.09.21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var mainWindowController = MainWindowController(windowNibName: .init("MainWindowController"))

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindowController.showWindow(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
