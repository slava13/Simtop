//
//  ViewController.swift
//  Simtop
//
//  Created by Slava on 9/28/20.
//  Copyright © 2020 Yaroslav Kopylov. All rights reserved.
//

import Cocoa
import MASShortcut
import ServiceManagement

class ViewController: NSViewController {
    
    let shortcutBinder = MASShortcutBinder.shared()!
    let helperBundleName = "com.badoo.SimTopLoginItem"
    
    @IBOutlet weak var launchCheckbox: NSButton!
    @IBOutlet weak var shortcutView: MASShortcutView!
    
    @IBAction func toggleAutoLaunch(_ sender: NSButton) {
        let isAuto = sender.state == .on
        SMLoginItemSetEnabled(helperBundleName as CFString, isAuto)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shortcutView.associatedUserDefaultsKey = .shortcutDefaultsKey
        let foundHelper = NSWorkspace.shared.runningApplications.contains {
            $0.bundleIdentifier == helperBundleName
        }
        
        launchCheckbox.state = foundHelper ? .on : .off
    }
}

typealias ViewControllerDefinitions = String
extension ViewControllerDefinitions {
    static let shortcutDefaultsKey = "customShortcut"
    
}
