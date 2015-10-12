//
//  Watermelon.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var watermelonTutorial:Bool = true
var watermelonsEaten:Int = 0 {
didSet {
    if(watermelonsEaten >= 5) {
        watermelonTutorial = false
    }
}
}

class Watermelon: Fruit {
    private var angle:Int = 90
    
    init(fruitType: Int) {
        if(watermelonTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            watermelonsEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}