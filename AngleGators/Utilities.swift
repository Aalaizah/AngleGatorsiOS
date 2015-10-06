//
//  Utilities.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/6/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import Foundation

extension Array {
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}