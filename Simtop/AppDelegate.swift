//
//  AppDelegate.swift
//  Simtop
//
//  Created by Slava on 9/28/20.
//  Copyright © 2020 Yaroslav Kopylov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let shortcutBinder = MASShortcutBinder.shared()!
    
    lazy var settingsController: NSWindowController? =
        NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "PreferencesWindow")
        as? NSWindowController
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupDefaultsShortcut()
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        }
        
        constructMenu()
        
        shortcutBinder.bindShortcut(withDefaultsKey: .shortcutDefaultsKey) {
            self.toggleAlwaysOnTop()
        }
    }    
}


extension AppDelegate {
    func setupDefaultsShortcut() {
        ObjcBridgingHelper.setupDefaultKeybindingIfNeeded(withKey: .shortcutDefaultsKey)
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.preferencesWindow(_:)), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Simtop", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    @objc func preferencesWindow(_ sender: NSMenuItem) {
        if let controller = settingsController {
            controller.window?.makeKeyAndOrderFront(self)
            controller.showWindow(self)
            NSApp.activate(ignoringOtherApps: true)
        }
    }
    
    func toggleAlwaysOnTop() {
        
        let source = """
                      tell application "Simulator"
                          activate
                      end tell

                      tell application "System Events" to tell process "Simulator"
                          set activeMenuItem to (value of attribute "AXMenuItemMarkChar" of menu item "Stay on Top" of menu "Window" of menu bar 1) is "✓" -- check if Status is "Availible"
                          if activeMenuItem is true then
                              tell application "Simulator"
                                  activate
                                  tell application "System Events" to tell process "Simulator"
                                      click menu item "Stay on Top" of menu "Window" of menu bar 1
                                      delay 0.5
                                      tell application "System Events"
                                          set visible of application process "Simulator" to false
                                      end tell
                                  end tell
                              end tell
                          else
                              tell application "Simulator"
                                  activate
                                  tell application "System Events" to tell process "Simulator"
                                      click menu item "Stay on Top" of menu "Window" of menu bar 1
                                      delay 0.5
                                  end tell
                              end tell
                          end if
                      end tell
                      """
        if let script = NSAppleScript(source: source) {
            var error: NSDictionary?
            script.executeAndReturnError(&error)
            if let err = error {
                print(err)
            }
        }
    }
}
