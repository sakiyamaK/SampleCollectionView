//
//  AppDelegate.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2020/06/06.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import Hero
import IQKeyboardManagerSwift
import UIKit

extension Notification.Name {
    static let injection = Notification.Name("INJECTION_BUNDLE_NOTIFICATION")
}

extension NotificationCenter {
    func addInjectionObserver(_ observer: Any, selector: Selector, object: Any?) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: .injection, object: object)
    }
}

// デバッグビルドでしか出ない
func DLog(_ obj: Any? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    var filename: NSString = file as NSString
    filename = filename.lastPathComponent as NSString
    if let obj = obj {
        print("[File:\(filename) Func:\(function) Line:\(line)] : \(obj)")
    } else {
        print("[File:\(filename) Func:\(function) Line:\(line)]")
    }
}

// リリースビルドでも出る
func ALog(_ obj: Any? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    var filename: NSString = file as NSString
    filename = filename.lastPathComponent as NSString
    if let obj = obj {
        debugPrint("[File:\(filename) Func:\(function) Line:\(line)] : \(obj)")
    } else {
        debugPrint("[File:\(filename) Func:\(function) Line:\(line)]")
    }
}

@main
//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
#endif
    
        let nav = UINavigationController(rootViewController: RootViewController())
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}


