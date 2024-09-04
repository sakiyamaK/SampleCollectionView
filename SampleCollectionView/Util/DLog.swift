//
//  DLog.swift
//  SampleCollectionView
//
//  Created by sakiyamaK on 2024/09/04.
//

import Foundation

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
