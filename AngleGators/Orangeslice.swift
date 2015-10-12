//
//  Orangeslice.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//
import UIKit
import SpriteKit

var orangesliceTutorial:Bool = true
var orangeslicesEaten:Int = 0 {
didSet {
    if(orangeslicesEaten >= 5) {
        orangesliceTutorial = false
    }
}
}

class Orangeslice: Fruit {
    private var angle:Int = 30
    
    init(fruitType: Int) {
        if(orangesliceTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            orangeslicesEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
