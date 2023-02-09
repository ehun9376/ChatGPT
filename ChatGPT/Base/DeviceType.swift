//
//  DeviceType.swift
//  Job1111
//
//  Created by Stephen Chui on 2018/9/18.
//  Copyright © 2018年 JobBank. All rights reserved.
//

import UIKit

@objc public class DeviceType: NSObject {
    
    @objc static public var iPhone: Bool {
        get {
            return UIDevice.current.userInterfaceIdiom == .phone
        }
    }
    
    @objc static public var iPhoneSE_Under: Bool {
        get {
            return UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.width <= 320
        }
    }
    
    @objc static public var iPhoneSE: Bool {
        get {
            return UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height == 568
        }
    }
    
    @objc static public var iPhoneX: Bool {
        get {
            return UIDevice.current.userInterfaceIdiom == .phone && (UIScreen.main.bounds.size.height == 780 || UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.height == 844 || UIScreen.main.bounds.size.height == 896 || UIScreen.main.bounds.size.height == 926 || UIScreen.main.bounds.size.height == 852 || UIScreen.main.bounds.size.height == 844 || UIScreen.main.bounds.size.height == 932)
        }
    }
    
    @objc static public var iPad: Bool {
        get {
            return UIDevice.current.userInterfaceIdiom == .pad
        }
    }
}
