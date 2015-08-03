//
//  CarteItem.swift
//  Carte
//
//  Created by 전수열 on 8/4/15.
//  Copyright (c) 2015 Suyeol Jeon. All rights reserved.
//

import Foundation

@objc public class CarteItem {

    public var name: String?
    public var version: String?
    public var licenseName: String?
    public var licenseText: String?

    public var displayName: String? {
        if let name = self.name, version = self.version {
            return "\(name) (\(version))"
        }
        return self.name
    }

    public init() {

    }

}
