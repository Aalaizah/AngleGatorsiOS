//
//  Appleslice.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var applesliceTutorial:Bool = true
var appleslicesEaten:Int = 0 {
didSet {
    if(appleslicesEaten >= 5) {
        applesliceTutorial = false
    }
}
}

class Appleslice: Fruit {
    private var angle:Int = 30
    
    init(fruitType: Int) {
        if(applesliceTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            appleslicesEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}