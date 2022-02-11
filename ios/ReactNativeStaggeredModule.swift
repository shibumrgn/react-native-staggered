//
//  ReactNativeStaggeredModule.swift
//  ReactNativeStaggeredModule
//
//  Copyright © 2022 Shibu Murugan. All rights reserved.
//

import Foundation

@objc(ReactNativeStaggeredModule)
class ReactNativeStaggeredModule: NSObject {
  @objc
  func constantsToExport() -> [AnyHashable : Any]! {
    return ["count": 1]
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
