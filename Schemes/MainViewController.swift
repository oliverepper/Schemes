//
//  MainViewController.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Cocoa
import UnregisterSchemeHandler

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

    private func reloadData() {
        entries.removeAllObjects()
        loadData(into: entries)
        arrayController.rearrangeObjects()
    }

    private func unregister() {
        arrayController.selectionIndexes.forEach { idx in
            let entry = (arrayController.arrangedObjects as! NSArray)[idx] as! Entry
            print("Going to unregister \(entry.handler.path)")
            UnregisterClient.unregiser(entry.handler) { [weak self] result in
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            }
        }
    }

    @IBAction func reloadData(_ sender: Any) {
        reloadData()
    }

    @IBAction func unregister(_ sender: Any) {
        unregister()
    }
}

public final class NSURLValueTransformer: ValueTransformer {
    public override class func transformedValueClass() -> AnyClass {
        return NSURL.self
    }

    public override class func allowsReverseTransformation() -> Bool {
        true
    }

    public override func transformedValue(_ value: Any?) -> Any? {
        guard let url = value as? NSURL else { return nil }
        return url.path
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let str = value as? String else { return nil }
        return NSURL(string: str)
    }
}

extension NSURLValueTransformer {
    static let name = NSValueTransformerName(String(describing: NSURLValueTransformer.self))

    public static func register() {
        let transformer = NSURLValueTransformer()
        print(name)
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}

final class UnregisterClient {
    class func unregiser(_ url: URL, reply: @escaping (Int32) -> Void) {
        let connection = NSXPCConnection(serviceName: "de.oliver-epper.UnregisterSchemeHandler")
        connection.remoteObjectInterface = NSXPCInterface(with: UnregisterSchemeHandlerProtocol.self)
        connection.resume()

        let service = connection.remoteObjectProxyWithErrorHandler { error in
            print("Error: \(error)")
        } as? UnregisterSchemeHandlerProtocol

        service?.unregister(url, withReply: reply)
    }
}
