//
//  Apple.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/8/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var appleTutorial:Bool = true
var applesEaten:Int = 0 {
    didSet {
        if(applesEaten >= 5) {
            appleTutorial = false
        }
    }
}

class Apple: Fruit {
    private var angle:Int = 70
    
    init(fruitType: Int) {
        if(appleTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            applesEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
