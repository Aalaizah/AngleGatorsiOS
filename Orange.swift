//
//  Orange.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var orangeTutorial:Bool = true
var orangesEaten:Int = 0 {
didSet {
    if(orangesEaten >= 5) {
        orangeTutorial = false
    }
}
}

class Orange: Fruit {
    private var angle:Int = 10
    
    init(fruitType: Int) {
        if(orangeTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            orangesEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

