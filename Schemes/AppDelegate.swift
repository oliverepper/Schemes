//
//  AppDelegate.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var mainWindowController = MainWindowController(windowNibName: .init("MainWindowController"))

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSURLValueTransformer.register()
        mainWindowController.window?.title = ProcessInfo.processInfo.processName
        mainWindowController.showWindow(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

