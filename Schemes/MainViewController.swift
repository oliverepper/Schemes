//
//  MainViewController.swift
//  Schemes
//
//  Created by Oliver Epper on 03.10.21.
//

import Cocoa

@_silgen_name("_LSCopySchemesAndHandlerURLs") func LSCopySchemesAndHandlerURLs(_: UnsafeMutablePointer<NSArray?>, _: UnsafeMutablePointer<NSMutableArray?>) -> OSStatus

class MainViewController: NSViewController {
    static let lsregister = "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
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

    @IBAction func unregister(_ sender: Any) {
        arrayController.selectionIndexes.forEach { idx in
            let entry = (arrayController.arrangedObjects as! NSArray)[idx] as! Entry
            let command = Self.lsregister + " -u " + entry.handler.path
            print(command)
        }
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

    public static func regiser() {
        let transformer = NSURLValueTransformer()
        print(name)
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
