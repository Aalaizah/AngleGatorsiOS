//
//  Strawberry.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var strawberryTutorial:Bool = true
var strawberriesEaten:Int = 0 {
didSet {
    if(strawberriesEaten >= 5) {
        strawberryTutorial = false
    }
}
}

class Strawberry: Fruit {
    private var angle:Int = 10
    
    init(fruitType: Int) {
        if(strawberryTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            strawberriesEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
