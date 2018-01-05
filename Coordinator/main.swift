//
//  main.swift
//  Coordinator
//
//  Created by Popa, Ryan on 12/21/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass? = NSClassFromString("CoordinatorTests.TestingAppDelegate") ?? AppDelegate.self
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass!))
